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
    @keyword1 = Request.search_flickr(@request.keyword1+", closeup", 'Small')
    @keyword2 = Request.search_clipart(@request.keyword2)
    @keyword3 = Request.search_flickr(@request.keyword3, 'Large')
  end

  private

  def request_params
    params.require(:request).permit(:id, :keyword1, :keyword2, :keyword3)
  end
end
