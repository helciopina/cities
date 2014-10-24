require 'system'
require 'connection'

class Guide

  # Starting ot the program
  def lauch!
    # Welcome message and clear the screen
    System.welcome_message
    System.clear
    # authentication and message of sucess/failure of authentication
    option = nil

    until option == 'exit'
      puts "  Use: <login> or <exit>."
      print "> "
      option = gets.chomp.downcase
      if option == 'login'
        Database.get_auth # get authentication
        System.clear
        System.authenticated

        todo = nil
        until todo == 'exit'
          System.clear

          puts "  Use: <add>, <find> or <exit>."
          print "> "
          todo = gets.chomp.downcase
          case todo
          when 'add'
            Database.add_city
          when 'find'
            Database.find_city
          when 'exit'
            break
          else
            puts "this is not included in our options"
          end
        end
        System.exit
      end
      break # Where the Program finishes.
    end
    System.logout_message
  end

end