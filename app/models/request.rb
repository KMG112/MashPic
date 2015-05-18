class Request < ActiveRecord::Base

  require 'open-uri'



  def self.search_clipart(input)

    user_input = input.split(" ").join("+")
    response = HTTParty.get("https://openclipart.org/search/json/?query=icon+"+user_input)

  return response["payload"][0]["svg"]["png_thumb"]

  end


  def self.search_flickr(input, labe)

    FlickRaw.api_key= Figaro.env.flickr_key
    FlickRaw.shared_secret= Figaro.env.flickr_secret

      list   = flickr.photos.search(:tags => input)

      numb = rand(0..20)
     
      id  = list[numb].id

      sizes = flickr.photos.getSizes :photo_id => id

      found_size = sizes.find {|s| s.label == labe }

      return found_size.source

  end



  def self.imageMagic(k1, k2, k3)

    FileUtils.remove_file(Rails.root + "public/collage.png")
    
    Request.save_pic(k1, 'keyword1')
    Request.save_pic(k2, 'keyword2')
    Request.save_pic(k3, 'keyword3')

    
    m = Magick::ImageList.new('public/keyword1.png', 'public/keyword2.png', 'public/keyword3.png')
    
    m[0].format = "png" #converting flickr jpg to png like clipart
    m[2].format = "png"

    
    m.each do |x|
      
      x.resize!(400,400) #resized images so that they can be averaged by imagemagick
      
    end

    all = m.average #compiles photos
    
    all.write(Rails.root + "public/collage.png") #creates file localy

    obj = S3_BUCKET.objects["collage.png"] #creates object in AWS bucket

    obj.write(
      file: 'public/collage.png',
      acl: :public_read
    )#writes item to AWS bucket

  end

  def self.save_pic(input, name)

    name = name+'.png' 

    root = Rails.root + 'public/'+name

    FileUtils.remove_file(root)

    open(root, 'wb') do |file|
      file << open(input).read
    end

    return root
   
  end



end
