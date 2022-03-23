require_relative 'config/load_files'

INITIAL_PRODUCTS = [
  { name: 'coca cola', price: 2.0, quantity: 10 },
  { name: 'sprite', price: 2.5, quantity: 10 },
  { name: 'fanta', price: 2.25, quantity: 10 },
  { name: 'orange juice', price: 3.0, quantity: 10 },
  { name: 'water', price: 3.25, quantity: 0 }
]

INITIAL_COINS = [
  { value: 5.0, quantity: 5 },
  { value: 3.0, quantity: 5 },
  { value: 2.0, quantity: 5 },
  { value: 1.0, quantity: 5 },
  { value: 0.5, quantity: 5 },
  { value: 0.25, quantity: 5 }
]

VendingMachine.new(products: INITIAL_PRODUCTS, coins: INITIAL_COINS).run
