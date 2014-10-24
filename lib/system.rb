class System
  def self.clear
    #puts "\n"*5 # Scrolls the screen 40 times
    puts "\a" # makes a litle noise to get the user attention
  end

  def self.authenticated
    puts "######################--:: Cities 1.0.0:: --###########################"
    puts "                           Authenticated                               "
    puts ""
  end

  def self.welcome_message
    puts "#######################################################################"
    puts "##################### Welcome to the System ###########################"
    puts "                        Not Authenticated                             "
  end

  def self.logout_message
    puts "#######################################################################"
    puts "                             Good Bye                                  "
    puts "#######################################################################"
  end

  def self.exit
    puts ""
    puts "Enter to quit..."
    pause = gets.chomp
  end
end
