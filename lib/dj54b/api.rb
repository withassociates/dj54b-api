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

      def volume
        Integer(spotify.tell("get the sound volume"))
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

    desc "Volume up"
    get :up do
      new_volume = [volume + 10, 100].min
      spotify.tell("set the sound volume to #{new_volume}")
    end

    desc "Volume down"
    get :down do
      new_volume = [volume - 10, 0].max
      spotify.tell("set the sound volume to #{new_volume}")
    end
  end
end
