require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'fog/aws'

require_relative 'database_config'
require_relative 'models/item'
require_relative 'models/offer_status'
require_relative 'models/offer'
require_relative 'models/photo'
require_relative 'models/user'

users = ['pam', 'clifton', 'ashley', 'jake', 'rachel']
addresses = ['1 Lollipop Dr', '2 Happy Place', '65 Whiteboard Rd', '16 Chair Ave', '11 Frick St' ]
suburbs = ['Hawthorn', 'Richmond', 'Carlton', 'St Kilda', 'Collingwood']
postcodes = [3122, 3121, 3053, 3182, 3066]

users.each_with_index do |user, index|
  u = User.new
  u.username = user
  u.email = "#{user}@email.com"
  u.password = 'abcd'
  u.address_line_1 = addresses[index]
  u.suburb = suburbs[index]
  u.postcode = postcodes[index]
  u.avatar = 'http://www.carderator.com/assets/avatar_placeholder_small.png'
  u.availability = "mon, tues evenings, and weekends"
  u.save
end

statuses = ['pending', 'declined', 'accepted', 'completed']

statuses.each do |status|
  s = OfferStatus.new
  s.stage = status
  s.save
end

items = ['apples', 'potatoes', 'tomatoes', 'peaches', 'lemons']
units = ['kg', 'g', 'pcs', 'kg', 'pcs']

items.each_with_index do |item, index|
  i = Item.new
  i.title = item
  i.description = 'I love gummi bears chocolate bar sugar plum. \
  Pudding danish candy danish sweet roll. Fruitcake biscuit candy. \
  Tootsie roll chocolate bear claw muffin.'
  i.quantity = rand(1..10)
  i.unit = units[index]
  i.user_id = index + 1
  i.save
end

5.times do |index|
  p = Photo.new
  p.item_id = index + 1
  p.image_link = "https://i.imgur.com/ewAXupq.png"
  p.save
end

# 4.times do |index|
#   o = Offer.new
#   o.proposer_user_id = index +1
#   o.proposer_item_id  = index +1
#   o.proposer_item_qty = rand(1..Item.find(o.proposer_item_id).quantity)
#   o.reviewer_user_id = index + 2
#   o.reviewer_item_id = index +2
#   o.reviewer_item_qty = rand(1..Item.find(o.reviewer_item_id).quantity)
#   o.status_id = rand(1..3)
#   o.meeting_point = "1 Main Road"
#   o.meeting_point_suburb = "Richmond"
#   o.save
# end