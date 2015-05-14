class Request < ActiveRecord::Base

  require 'open-uri'

  def self.search_clipart(input)

    user_input = input.split(" ").join("+")
    response = HTTParty.get("https://openclipart.org/search/json/?query=icon+"+user_input)

  return response["payload"][0]["svg"]["png_thumb"]

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



    key1 = Request.save_pic(k1, 'keyword1')
    key2 = Request.save_pic(k2, 'keyword2')
    key3 = Request.save_pic(k3, 'keyword3')

    m = Magick::ImageList.new(key1, key2, key3)

    m[1].format = "jpg" #clipart is png file. converts
      

    all = m.average

    all.write(Rails.root + "public/collage.jpg")
    # ultimately to AWS
  end

  def self.save_pic(input, name)
    name = name+'.jpg'
    root = Rails.root + 'public/'+name
    # FileUtils.remove_file(Rails.root + "public/collage.jpg")
    FileUtils.remove_file(root)
    open(root, 'wb') do |file|
      file << open(input).read
    end
    return root
  end

end
