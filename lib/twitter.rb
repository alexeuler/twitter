module Twitter
  def follow(users)
    users = users.split(' ') if users.is_a? String
    users = [users] unless users.is_a? Array
    users.each do |user|
      user.gsub('@', '')
      $twitter.follow! user
    end
  end
end