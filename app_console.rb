require 'pry'
require_relative 'database_config'
also_reload File.expand_path(__dir__, 'models/*')

binding.pry