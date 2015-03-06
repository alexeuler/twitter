require_relative '../../lib/twitter'

class ApiController < ApplicationController
  def follow
    users = params[:data][:users]
    begin
      Twitter::follow users
    rescue Exception => e
      puts e.message
      render json: e.message
    end
    render json: 'Ok'
  end
end
