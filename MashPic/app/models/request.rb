class Request < ActiveRecord::Base
  include HTTParty

  # def self.search(keyword)
  # response = HTTParty.get("http://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?",
  #   :headers =>{
  #       "tags" => keyword,
  #       "format" => "json"
  #   })
  #
  #
  # end
end
