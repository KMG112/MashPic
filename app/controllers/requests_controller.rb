# I'd call this something less generic, like MashPicsController

class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      redirect_to @request
    else
      render :new
    end
  end

  def show
    @request = Request.find(params[:id])
    # The next 3 lines don't need to happen in the controller. All in the info needed is in the
    # request class, so in theory, could have one method on the request, e.g. Request.generatePic()
    # that does all the relevant work.
    # I would also argue that this work should be done on creation, not on show.
    @keyword1 = Request.search_flickr(@request.keyword1+", closeup", 'Small')
    @keyword2 = Request.search_clipart(@request.keyword2)
    @keyword3 = Request.search_flickr(@request.keyword3, 'Large')
    @mash = Request.imageMagic(@keyword1, @keyword2, @keyword3)
  end

  private

  def request_params
    params.require(:request).permit(:id, :keyword1, :keyword2, :keyword3)
  end
end
