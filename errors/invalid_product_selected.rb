class InvalidProductSelected < StandardError
  def message
    'Selected product does not exist.'
  end
end
