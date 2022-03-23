class ReturnChangeService
  def initialize(coins:, user_balance:)
    @coins          = coins
    @user_balance   = user_balance
    @returned_coins = []
  end

  def call
    calculate_returned_coins

    if user_balance.zero?
      { success: true, coins: coins, returned_coins: returned_coins }
    else
      { success: false }
    end
  end

  private

  attr_accessor :coins, :user_balance, :returned_coins

  def calculate_returned_coins
    sorted_coins.each do |coin|
      next if coin[:quantity].zero?
      next if user_balance < coin[:value]

      loop do
        self.user_balance = calculate_new_balance(coin[:value])
        coin[:quantity]  -= 1

        return_coin(coin[:value])

        break if coin[:quantity].zero?
        break if user_balance < coin[:value]
      end
    end
  end

  def sorted_coins
    coins.sort_by { |coin| -coin[:value] }
  end

  def return_coin(value)
    returned_coin = returned_coins.find { |coin| coin[:value] == value }

    if returned_coin.nil?
      returned_coins << { value: value, quantity: 1 }
    else
      returned_coin[:quantity] += 1
    end
  end

  def calculate_new_balance(coin_value)
    AddMoney.new(user_balance, -coin_value).call
  end
end
