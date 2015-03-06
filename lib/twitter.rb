module Twitter

  def self.get_followings
    followings = $twitter.friends.to_a
    cursor = '-1'
    while cursor != 0 do
      users = ({:cursor => cursor})
      cursor = users.next_cursor
      followings+= users.attrs[:users].map { |user| user[:screen_name] }
    end
    followings
  end

  def self.follow(users)
    followings = get_followings
    users = users.split(' ') if users.is_a? String
    users = [users] unless users.is_a? Array
    users.each do |user|
      user.gsub('@', '')
      $twitter.follow!(user) unless followings.include?(user)
    end
  end
end