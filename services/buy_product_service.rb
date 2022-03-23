class BuyProductService
  def initialize(products:, coins:, user_balance:, user_input:)
    @products     = products
    @coins        = coins
    @user_balance = user_balance
    @user_input   = user_input
  end

  def call
    raise InvalidProductSelected if selected_product.nil?
    raise OutOfStockProductSelected if selected_product[:quantity].zero?
    raise InsufficientBalance if new_balance.negative?

    if can_return_change?
      selected_product[:quantity] -= 1

      { success: true, products: products, new_balance: new_balance }
    else
      { success: false }
    end
  end

  private

  attr_reader :products, :coins, :user_balance, :user_input

  def selected_product
    @selected_product ||= products.find { |product| product[:name] == user_input.downcase }
  end

  def new_balance
    @new_balance ||= calculate_new_balance
  end

  def calculate_new_balance
    AddMoney.new(user_balance, -selected_product[:price]).call
  end

  def can_return_change?
    result = ReturnChangeService.new(coins: coins, user_balance: new_balance).call

    result[:success]
  end
end
