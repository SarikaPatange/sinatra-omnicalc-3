require "sinatra"
require "sinatra/reloader"
require "http"
require "sinatra/cookies"

get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
  #erb(:home)
end
get("/umbrella") do
  erb(:umbrella_form)
end
post("/process_umbrella") do
  @user_location = params.fetch("user_location")
  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=AIzaSyDKz4Y3bvrTsWpPRNn9ab55OkmcwZxLOHI"
  @raw_response = HTTP.get(gmaps_url).to_s
  @parsed_response = JSON.parse(@raw_response)
  @loc_hash = @parsed_response.dig("results", 0, "geometry", "location")
  @latitude = @loc_hash.fetch("lat")
  @longitude = @loc_hash.fetch("lng")
  erb(:umbrella_results)
end
get("/message") do
  erb(:message_form)
end
post("/process_single_message") do
  erb(:message_form_results)
end
get("/chat") do
  erb(:chat)
end
post("/add_message_to_chat") do
  @user_message = params.fetch("user_message")
  erb(:chat_results)
end
