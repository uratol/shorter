class MainController < ApplicationController

  def index

  end

  def encode
    respond_to do |format|
      format.json{ render json: {key: Link.encode(params[:url])}.to_json }
    end
  end

  def redirect_key
    link = Link.decode(params[:key])
    if link
      redirect_to(link)
    else
      redirect_404
    end
  end

end
