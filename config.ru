$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'bundler/setup'
require 'dj54b'

DJ54B.spotify.launch

run DJ54B::API
