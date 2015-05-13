class Request < ActiveRecord::Base


  def self.search_clipart(input)

    user_input = input.split(" ").join("+")
    response = HTTParty.get("https://openclipart.org/search/json/?query=icon+"+user_input)

  return response["payload"][0]["svg"]["url"]

  end

  def self.search_flickr(input, labe)
    FlickRaw.api_key= "af6cb124a512efe6089bfbaaf29669ac"
    FlickRaw.shared_secret= "ae170a93938eaded"

      list   = flickr.photos.search(:tags => input)

      numb = rand(0..20)
      
      id  = list[numb].id

      sizes = flickr.photos.getSizes :photo_id => id

      found_size = sizes.find {|s| s.label == labe }

      return found_size.source

  end

  def self.imageMagic(k1, k2, k3)
    m = Magick::ImageList.new(k1, k2, k3)
    all = m.average
    all.write(RAILS_ROOT + "/public/collage.png")
  end

end
