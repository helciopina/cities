require 'mysql2'
require 'system'
require 'formatador'

class Database
  # Questions to the user to get the authentication data.
  def self.get_auth
    # You can uncomment the 2 lines below if you want to specify the server name.
    # print "hostname: "
    # host = gets.chomp

    print "Username: "
    @user = gets.chomp.downcase

    # Get a password but hide it from view.
    @password = ask("Password(#{@user}): "){|p| p.echo = false}

    # You can uncomment the 2 lines below if you want to specify the system (database name).
    print "System: "
    @database = gets.chomp.downcase

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

    print "District: "
    district_name = gets.chomp.capitalize

    print "Population: "
    population = gets.chomp.to_s

    # Execute the query
    @session.query("INSERT INTO City (Name, CountryCode, District, Population) VALUES(\"#{city_name}\", \"#{country_code}\", \"#{district_name}\", #{population})")

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

  def self.delete_city
    # Connect to the database
    connect(@user, @password, @database)

    # Clear the screen
    System.clear

    # Ask the name of the city you want to delete
    print "City Name: "
    city_name = gets.chomp.capitalize

    # Find the City, and adds it to city_cel array
    city_sel = []
    @session.query("SELECT * FROM City WHERE Name=\"#{city_name}\"").each do |city|
      city_sel << city
    end

    # If the query turns out empty
    if city_sel.empty?
      puts "There's no such City in our database."
    else
      # Confirm if the user want really delete the City
      puts "Are you sure you want to delete #{city_name} ? (y/n)"
      response = gets.chomp.downcase
      if response == "y"
      # If the query has something then delete the city found.
      @session.query("DELETE FROM City WHERE Name=\"#{city_name}\"")
      puts "You have deleted #{@session.affected_rows} records."
      end
    end
    # Disconnect from the database
    disconnect
  end

  # Method to select countries
  def select(code, session)

    country = session.query("SELECT * FROM City WHERE CountryCode=\"#{code}\"")
  end
  
end