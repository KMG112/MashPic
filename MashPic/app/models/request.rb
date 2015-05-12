class Request < ActiveRecord::Base

  def self.search(input, labe)
    FlickRaw.api_key= "af6cb124a512efe6089bfbaaf29669ac"
    FlickRaw.shared_secret= "ae170a93938eaded"

      list   = flickr.photos.search(:tags => input)

      numb = rand(0..20)
      
      id  = list[numb].id

      sizes = flickr.photos.getSizes :photo_id => id

      found_size = sizes.find {|s| s.label == labe }

      return found_size.source

  end

end
