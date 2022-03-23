class VendingMachine
  include ::PrintHelper

  ERRORS_TO_HANDLE = [
    ::InvalidCoinInserted,
    ::InvalidProductSelected,
    ::OutOfStockProductSelected,
    ::InsufficientBalance
  ]

  def initialize(products:, coins:)
    @products     = products
    @coins        = coins
    @user_balance = 0.0
  end

  def run
    print_welcome_message

    user_input = gets.chomp

    while user_input != 'x'
      begin
        handle_user_input(user_input)

        user_input = gets.chomp
      rescue *ERRORS_TO_HANDLE => e
        puts e.message

        next user_input = gets.chomp
      end
    end
  end

  private

  attr_accessor :products, :coins, :user_balance

  def handle_user_input(user_input)
    if user_input == 'x'
      nil # exit program.
    elsif numeric?(user_input)
      insert_coin(user_input)

      print_user_balance(user_balance)
    else
      buy_product(user_input)

      return_change

      print_user_balance(user_balance)
    end
  end

  def insert_coin(user_input)
    result = InsertCoinService.new(
      coins: coins,
      user_balance: user_balance,
      user_input: user_input
    ).call

    self.coins        = result[:coins]
    self.user_balance = result[:new_balance]
  end

  def buy_product(user_input)
    result = BuyProductService.new(
      products: products,
      coins: coins,
      user_balance: user_balance,
      user_input: user_input
    ).call

    if result[:success]
      self.products     = result[:products]
      self.user_balance = result[:new_balance]

      print_product_bought(user_input)
    else
      print_no_change_available
    end
  end

  def return_change
    result = ReturnChangeService.new(
      coins: coins,
      user_balance: user_balance
    ).call

    self.coins        = result[:coins]
    self.user_balance = 0.0

    print_returned_coins(result[:returned_coins])
  end

  def numeric?(string)
    true if Float(string)
  rescue StandardError
    false
  end
end
