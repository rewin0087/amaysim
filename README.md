# amaysim

#### Requirements:
  install ruby 2.3.0
  
  install bundler gem
  
  do bundle install after bundler gem installed
  
  run rspec to run test base from the scenarios in the programming exercise scenarios
  
  or
  
  run irb from the root directory and load the following file
  
  then run the each exercises manually.
  
  ```ruby
  load './product.rb'
  load './price_rule.rb'
  load './shopping_cart.rb'

  cart = ShoppingCart.new(PriceRule::ALL)
  cart.add(Product.ult_small(3))
  cart.add(Product.ult_large)
  cart.total # 94.70
  cart.items # list of items purchased
  ```
