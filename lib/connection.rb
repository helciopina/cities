require 'mysql2'
require 'system'
require 'formatador'

class Database
  # Questions to the user to get the authentication data.
  def self.get_auth
    # You can uncomment the 2 lines below if you want to specify the server name.
    # print "hostname: "
    # host = gets.chomp

    print "username: "
    @user = gets.chomp

    # Get a password but hide it from view.
    @password = ask("password(#{@user}): "){|p| p.echo = false}

    # You can uncomment the 2 lines below if you want to specify the system (database name).
    print "System: "
    @database = gets.chomp

    # Connect to the database
    connected = Database.connect(@user, @password, @database)
  end

  # Method that connect to the database
  def self.connect(host='localhost', user, password, database)

    @session = Mysql2::Client.new(:host => "#{host}", :username => "#{user}", :password => "#{password}", :database => "#{database}")
  end

  # method that disconnect from the database if connected
  def self.disconnect
    @session.close if @session
  end

  # method to add new city to the database
  def self.add_city
    # Connect to the database
    connect(@user, @password, @database)

    # Clear the screen
    System.clear

    # Ask the Name of the city, country code, District, Population
    print "City: "
    city_name = gets.chomp.capitalize

    print "Country Code: "
    country_code = gets.chomp.upcase
    print country_code

    print "District: "
    district_name = gets.chomp.capitalize

    print "Population: "
    population = gets.chomp

    # Execute the query
    @session.query("INSERT INTO City (Name, CountryCode, District, Population) VALUES(\"#{city_name}\", \"#{country_code}\", \"#{district_name}\", \"#{population})\"")

    #Disconnect from the database
    disconnect
  end

  # method to find a certain city in the database
  def self.find_city
    # Connect to the database
    connect(@user, @password, @database)

    # Clear the screen
    System.clear

    # Ask the Name of the Country Code

    print "Country Code: "
    country_code = gets.chomp.upcase

    # Execute the query
    city = @session.query("SELECT * FROM City WHERE CountryCode=\"#{country_code}\"")
    if city
      Formatador.display_table(city)
    else
      puts "Could not find a country with the code #{country_code}"
    end
    #Disconnect from the database
    disconnect
  end

  # Method to select countries
  def select(code, session)

    country = session.query("SELECT * FROM City WHERE CountryCode=\"#{code}\"")
  end
  
end
