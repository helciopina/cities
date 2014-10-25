class System
  def self.clear
    puts "\a" # makes a litle noise to get the user attention
  end

  def self.authenticated
    puts "######################--:: Cities 1.0.0:: --###########################"
    puts "                           Authenticated                               "
  end

  def self.welcome_message
    puts "##################### Welcome to the System ###########################"
    puts "                        Not Authenticated                             "
  end

  def self.logout_message
    puts "#######################################################################"
    puts "                             Good Bye                                  "
  end

  def self.exit
    puts ""
    puts "Hit enter to quit..."
    pause = gets.chomp
  end

  def self.actions
    puts "  Use: <add>, <find>, <delete> or <exit>."
    print "> "
  end
end
