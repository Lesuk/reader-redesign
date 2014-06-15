class Video < ActiveRecord::Base
	belongs_to :user
	before_save :fetch_uid

	YOUTUBE_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
	validates :link, presence: true, format: YOUTUBE_LINK_FORMAT

	default_scope { order('created_at DESC') }

private
	
	def fetch_uid
		uid = link.match(YOUTUBE_LINK_FORMAT)

	    self.uid = uid[2] if uid && uid[2]

	    if self.uid.to_s.length != 11
	      self.errors.add(:link, 'is invalid.')
	      false
	    else
	      get_additional_info
	    end
	end

	def get_additional_info
	    begin
	      client = YouTubeIt::OAuth2Client.new(dev_key: ENV["YT_API_KEY"])
	      video = client.video_by(uid)
	      self.title = video.title
	      self.duration = parse_duration(video.duration)
	      self.author = video.author.name
	      self.likes = video.rating.likes
	      self.dislikes = video.rating.dislikes
	      self.published_at = video.published_at
	      self.views = video.view_count
	    rescue
	     # self.title = '' ; self.duration = '00:00:00' ; self.author = '' ; self.likes = 0 ; self.dislikes = 0; self.views = 0;
	    end
  	end

	def parse_duration(d)
	    hr = (d / 3600).floor
	    min = ((d - (hr * 3600)) / 60).floor
	    sec = (d - (hr * 3600) - (min * 60)).floor

	    hr = '0' + hr.to_s if hr.to_i < 10
	    min = '0' + min.to_s if min.to_i < 10
	    sec = '0' + sec.to_s if sec.to_i < 10

	    hr.to_s + ':' + min.to_s + ':' + sec.to_s
  end

end
