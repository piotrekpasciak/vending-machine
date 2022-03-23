class InvalidCoinInserted < StandardError
  def message
    'Invalid coin was inserted.'
  end
end
