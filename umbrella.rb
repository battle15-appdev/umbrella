p "Where are you located?"

#user_location = gets.chomp

#hard-coding address to prevent retping location during runs

user_location = gets.chomp
p user_location

#lets developers read pages on the internet
require "open-uri"
#Should be a string for API URL of desired page

#hard coding the API URL to prevent it from clogging the code.

#STRING ADDITION
gmaps_api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location +"&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

#GSUB METHOD
#full_url = https://maps.googleapis.com/maps/api/geocode/json?address=200%20s%20wacker&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY
#subbed_string = full_url.gsub("uic", user_location)

# STRING INTERPOLATION
#"https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

#p URI.open(gmaps_api_url).read

#p gmaps_api_url

raw_gmaps_data = URI.open(gmaps_api_url).read

# require JSON to use JSON.parse("")
# if a string is provided, then it will return ruby content

require "json"

parsed_gmaps_data = JSON.parse(raw_gmaps_data) 

#Peeling off layers one layer at a time with .fetch and .at  until you get to  

results_array = parsed_gmaps_data.fetch("results")

first_result = results_array.at(0)

geometry = first_result.fetch("geometry")

location = geometry.fetch("location")

latitude = location.fetch("lat")

longitude = location.fetch("lng")

#p latitude
#p longitude

#Temperature

temp_api_url = "https://api.darksky.net/forecast/26f63e92c5006b5c493906e7953da893/#{latitude},#{longitude}"
#p temp_api_url

raw_temp_data = URI.open(temp_api_url). read

parsed_temp_data = JSON.parse(raw_temp_data)

#p parsed_temp_data

current = parsed_temp_data.fetch("currently")

curtemp = current.fetch("temperature") 

cursum = current.fetch("summary")

# For each of the next twelve hours, check if the precipitation probability is greater than 10%.

# If so, print a message saying how many hours from now and what the precipitation probability is.
# If any of the next twelve hours has a precipitation probability greater than 10%, print "You might want to carry an umbrella!"

# If not, print "You probably won't need an umbrella today."

hourly = parsed_temp_data.fetch("hourly")

hrdata = hourly.fetch("data") 

#p hrdata

hrtm = hrdata.at(1).fetch("time")

p hrtm

#p "It is " + curtemp.to_s + (" degrees out today! It will be a " + cursum.downcase + " day!")

hrdata.each do |index|
  
  #p index.fetch("precipProbability")

  if index.fetch("precipProbability") > 0.10
    p ("You might want to carry an umbrella")
  elsif index.fetch("precipProbability") 

    p ("You probably won't need an umbrella today")
  end

end



#p "It is " + curtemp.to_s + (" degrees out today! It will be a " + cursum.downcase + " day!")
#p 
