$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'bundler/setup'
require 'dj54b'

run DJ54B::API
