class OutOfStockProductSelected < StandardError
  def message
    'Selected product is out of stock.'
  end
end
