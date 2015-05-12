class Request < ActiveRecord::Base

  def self.search(input, labe)

      list   = flickr.photos.search(:tags => input)

      id  = list[0].id

      sizes = flickr.photos.getSizes :photo_id => id

      found_size = sizes.find {|s| s.label == labe }

      return found_size.source

  end

end
