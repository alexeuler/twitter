module Twitter

  def self.get_followings
    # SLICE_SIZE = 100
    # CSV.open("#{twitter_username}_friends_list.txt", 'w') do |csv|
    #   twitter_client.friend_ids(twitter_username).each_slice(SLICE_SIZE).with_index do |slice, i|
    #     twitter_client.users(slice).each_with_index do |f, j|
    #       csv << [i * SLICE_SIZE + j + 1, f.name, f.screen_name, f.url, f.followers_count, f.location.gsub(/\n+/, ' '), f.created_at, f.description.gsub(/\n+/, ' '), f.lang, f.time_zone, f.verified, f.profile_image_url, f.website, f.statuses_count, f.profile_background_image_url, f.profile_banner_url]
    #     end
    #   end
    # end
  end

  def self.parse_flitter(html_text)
    result = []
    html_doc = Nokogiri::HTML(html_text)
    rows= html_doc.css('div.userRow')
    rows.each do |row|
      status = row.css('button.Follow').first
      if status
        name_node = row.css('a.screen_name')
        if name_node.count > 0
          name=name_node.first.content.to_s
          result << name
        end
      end
    end
    result
  end

  def self.follow_followers(user,from)
    follow_limit=1000
    user = user.gsub('@', '')
    from||=0
    ids=[]
    begin
      ids = $twitter.follower_ids(user)
    rescue Exception => e
      Rails.logger.error "Follow_followers on #{user || 'Nil user'} raised #{e.message}"
    end
    follow_count=0
    ids.each(from) do |id|
      begin
        result = $twitter.follow!(id)
        Rails.logger.info "Follow_followers on #{id || 'Nil user'} ok with result #{result}"
      rescue Exception => e
        Rails.logger.error "Follow_followers on #{id || 'Nil user'} raised #{e.message}"
      end
      follow_count+=1
      break if follow_count>follow_limit
    end
  end

  def self.follow(users)
    # followings = get_followings
    users = users.split(' ') if users.is_a? String
    users = [users] unless users.is_a? Array
    users.each do |user|
      user.gsub!('@', '')
      unless user.blank? or user==nil
        begin
          result = $twitter.follow!(user) # unless followings.include?(user)
          Rails.logger.info "Follow on #{user || 'Nil user'} ok with result #{result}"
        rescue Exception => e
          Rails.logger.error "Follow on #{user || 'Nil user'} raised #{e.message}"
        end
      end
    end
  end
end