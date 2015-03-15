require_relative '../../lib/twitter'

class ApiController < ApplicationController
  def follow
    users = params[:data][:users]
    Twitter::follow users
    render json: 'Ok'
  end

  def parse_flitter
    file = params[:data][:file]
    contents = file.read
    users = Twitter::parse_flitter contents
    render json: users
  end

  def follow_followers
    user = params[:data][:user]
    from = params[:data][:from] && params[:data][:from].to_i
    users = Twitter::follow_followers user, from
    render json: users
  end

end
