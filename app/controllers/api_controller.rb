require_relative '../../lib/twitter'

class ApiController < ApplicationController
  def follow
    users = params[:data][:users]
    Twitter::follow users
    render json: 'Ok'
  end

  def parse
    file = params[:data][:file]
    contents = file.read
    users = Twitter::parse_flitter contents
    render json: users
  end
end
