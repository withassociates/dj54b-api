require 'bundler/setup'
require 'grape'
require 'osaka'

module DJ54B
  class API < Grape::API
    version 'v1', using: :header, vendor: 'dj54b'
    format :json

    helpers do
      def spotify
        @spotify ||= Osaka::RemoteControl.new('Spotify').tap { |control|
          control.launch unless control.running?
        }
      end
    end

    desc "Play"
    get :play do
      spotify.tell('play')
    end

    desc "Pause"
    get :pause do
      spotify.tell('pause')
    end

    desc "Next track"
    get :next do
      spotify.tell('next track')
    end

    desc "Current track"
    get :info do
      {
        name: spotify.tell("get the current track's name").strip,
        artist: spotify.tell("get the current track's artist").strip
      }
    end
  end
end
