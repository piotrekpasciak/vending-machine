class InsertCoinService
  def initialize(coins:, user_balance:, user_input:)
    @coins        = coins
    @user_balance = user_balance
    @user_input   = user_input
  end

  def call
    raise InvalidCoinInserted if matching_coin.nil?

    matching_coin[:quantity] += 1

    { coins: coins, new_balance: new_balance }
  end

  private

  attr_reader :coins, :user_balance, :user_input

  def matching_coin
    @matching_coin ||= coins.find { |coin| BigDecimal(coin[:value], 2) == BigDecimal(user_input.to_f, 2) }
  end

  def new_balance
    @new_balance ||= calculate_new_balance
  end

  def calculate_new_balance
    AddMoney.new(user_balance, matching_coin[:value]).call
  end
end
