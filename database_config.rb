require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'produce'
}

ActiveRecord::Base.establish_connection(options)