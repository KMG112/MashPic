# I'd call this class somethign more descriptive, like MashPic
class Request < ActiveRecord::Base

  require 'open-uri'

  def self.search_clipart(input)
    user_input = input.split(" ").join("+")
    response = HTTParty.get("https://openclipart.org/search/json/?query=icon+"+user_input)

    return response["payload"][0]["svg"]["png_thumb"]

  end

  # you had a typo labe -> label
  def self.search_flickr(input, label)

    FlickRaw.api_key= Figaro.env.flickr_key
    FlickRaw.shared_secret= Figaro.env.flickr_secret

    # indentation was off here
    list   = flickr.photos.search(:tags => input)
    numb = rand(0..20)     
    id  = list[numb].id
    sizes = flickr.photos.getSizes :photo_id => id
    found_size = sizes.find {|s| s.label == label }

    return found_size.source

  end


  # re: my comments in the controller, since you're always calling these methods with
  # the same keyword number, I'd do something like this:
  # def makeMashPic()  
  def self.imageMagic(k1, k2, k3)

    FileUtils.remove_file(Rails.root + "public/collage.png")
    
    # Request.save_pic(k1, 'keyword1')
    # Request.save_pic(k2, 'keyword2')
    # Request.save_pic(k3, 'keyword3')
    pic1 = Request.search_flicker(keyword1+", closeup", 'Small')
    pic2 = Request.search_clipart(keyword2)
    pic3 = Request.search_flicker(keyword3)
    Request.save_pic(pic1, 'keyword1')
    Request.save_pic(pic2, 'keyword2')
    Request.save_pic(pic3, 'keyword3')

    m = Magick::ImageList.new('public/keyword1.png', 'public/keyword2.png', 'public/keyword3.png')
    
    m[0].format = "png" #converting flickr jpg to png like clipart
    m[2].format = "png"

    # you have a lot of extra new lines which are not idiomatic ruby style.
    m.each do |x|  
      x.resize!(400,400) #resized images so that they can be averaged by imagemagick
    end

    all = m.average #compiles photos

    # why not include the request ID in the file name so you don't over-write the
    # same image each time? this would allow going back to old requests.
    all.write(Rails.root + "public/collage#{id}.png") #creates file localy
    obj = S3_BUCKET.objects["collage#{id}.png"] #creates object in AWS bucket
    obj.write(
      file: "public/collage#{id}.png",
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
