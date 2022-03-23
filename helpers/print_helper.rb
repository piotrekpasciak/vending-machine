module PrintHelper
  def print_welcome_message
    puts "###            Vending Machine           ###\n"\
         "### Enter number to insert coin          ###\n"\
         "### Enter product name to choose product ###\n"\
         "### Enter 'x' to exit program            ###\n"\
         "                                            \n"\
         "### Current balance: 0.00 ###\n"
  end

  def print_user_balance(user_balance)
    puts "\n### Current balance: #{format('%.2f', user_balance)} ###\n"
  end

  def print_returned_coins(returned_coins)
    returned_coins.each do |coin|
      puts "### Returning #{format('%.2f', coin[:value])} x#{coin[:quantity]} ###\n"
    end
  end

  def print_product_bought(product_name)
    puts "### #{product_name.capitalize} was bought ###\n"
  end

  def print_no_change_available
    puts "### No change available. Please enter coins matching product price ###\n"
  end
end
