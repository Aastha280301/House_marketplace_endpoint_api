require 'httparty'
require 'nokogiri'

namespace :scrape do
  task urhouse: :environment do
    url = "https://www.urhouse.com.tw/en/rentals"
    response = HTTParty.get(url)

    if response.code == 200
      doc = Nokogiri::HTML(response.body) 
      data = {
        "urhouse.rental.fieldset.type.residential" => "\u4f4f\u5b85\u689d\u4ef6"
      }

      residential_data = {}

      data.each do |key, value|
        if key.include?("type.residential")
          residential_data[key] = value
        end
      end
    else
      puts "Failed to fetch data from the URL. HTTP Response Code: #{response.code}"
    end
  end
end