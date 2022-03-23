class InsufficientBalance < StandardError
  def message
    'Insufficient balance, please insert more coins.'
  end
end
