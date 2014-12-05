require 'dj54b/spotify'
require 'grape'

module DJ54B
  class API < Grape::API
    format :json

    helpers do
      def spotify
        DJ54B.spotify
      end

      def volume
        Integer(spotify.tell("get the sound volume"))
      end

      def state
        spotify.tell("get the player state").strip
      end

      def info
        {
          track: {
            id: spotify.tell("get the current track's id").strip,
            name: spotify.tell("get the current track's name").strip,
            artist: spotify.tell("get the current track's artist").strip,
          },
          volume: volume,
          state: state
        }
      end
    end

    before do
      header 'Access-Control-Allow-Origin', '*'
      header 'Access-Control-Allow-Methods', 'GET, PUT, HEAD, OPTIONS'
    end

    desc "Play"
    get :play do
      spotify.tell('play')
      info
    end

    desc "Pause"
    get :pause do
      spotify.tell('pause')
      info
    end

    desc "Next track"
    get :next do
      spotify.tell('next track')
      info
    end

    desc "Current track"
    get :info do
      info
    end

    desc "Volume up"
    get :up do
      new_volume = [volume + 6, 100].min
      spotify.tell("set the sound volume to #{new_volume}")
      info
    end

    desc "Volume down"
    get :down do
      new_volume = [volume - 4, 0].max
      spotify.tell("set the sound volume to #{new_volume}")
      info
    end
  end
end
