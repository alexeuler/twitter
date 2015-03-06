require_relative '../../lib/twitter'

class ApiController < ApplicationController
  def follow
    users = params[:data][:users]
    Twitter::follow users
  end
end
