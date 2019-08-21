require_relative 'database_config'
require_relative 'models/item'
require_relative 'models/offer_status'
require_relative 'models/offer'
require_relative 'models/photo'
require_relative 'models/user'

users = ['pam', 'clifton', 'ashley', 'jake', 'rachel']

users.each do |user|
  u = User.new
  u.username = user
  u.email = "#{user}@email.com"
  u.password = 'abcd'
  u.description = 'I love gummi bears chocolate bar sugar plum. \
  Pudding danish candy danish sweet roll. Fruitcake biscuit candy. \
  Tootsie roll chocolate bear claw muffin.'
  u.postcode = rand(3000..3050)
  u.avatar = 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'
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
units = ['kg', 'g', 'pcs']

items.each_with_index do |item, index|
  i = Item.new
  i.title = item
  i.quantity = rand(1..10)
  i.unit = units.sample
  i.user_id = index + 1
  i.save
end

5.times do |index|
  p = Photo.new
  p.item_id = index + 1
  p.image_link = 'https://201758-624029-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2017/03/img-placeholder.png'
  p.save
end

4.times do |index|
  o = Offer.new
  o.proposer_user_id = index +1
  o.proposer_item_id  = index +1
  o.proposer_item_qty = rand(1..Item.find(o.proposer_item_id).quantity)
  o.reviewer_user_id = index + 2
  o.reviewer_item_id = index +2
  o.reviewer_item_qty = rand(1..Item.find(o.reviewer_item_id).quantity)
  o.status_id = rand(1..3)
  o.save
end