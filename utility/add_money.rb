class AddMoney
  def initialize(first_value, second_value)
    @first_value  = first_value
    @second_value = second_value
  end

  def call
    new_amount_in_cents = BigDecimal(first_value * 100, 0) + BigDecimal(second_value * 100, 0)

    new_amount_in_cents / BigDecimal(100)
  end

  private

  attr_reader :first_value, :second_value
end
