# Hace require de los gems necesarios.
# Revisa: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
require 'twitter'
require 'oauth'
# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Configura los controllers y los helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'uploaders', '*.rb')].each { |file| require file }

# Configura la base de datos y modelos 
require APP_ROOT.join('config', 'database')
# Comunica el archivo .yml para inicializar la aplicación


env_config = YAML.load_file(APP_ROOT.join('config', 'twitt.yaml'))

env_config.each do |key, value|
  ENV[key] = value
end
#Este archivo toma las variables del .yml para inicializar el cliente
CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_KEY"]
  config.consumer_secret     = ENV["TWITTER_SECRET"]
  
end