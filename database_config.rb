require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'produce'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)