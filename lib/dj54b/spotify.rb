require 'osaka'

module DJ54B
  def self.spotify
    Osaka::RemoteControl.new('Spotify')
  end
end
