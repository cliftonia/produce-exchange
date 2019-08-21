require 'pry'
require 'sinatra'
require 'sinatra/flash'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'fog/aws'

require_relative 'database_config'
require_relative 'models/item'
require_relative 'models/offer_status'
require_relative 'models/offer'
require_relative 'models/photo'
require_relative 'models/user'

binding.pry