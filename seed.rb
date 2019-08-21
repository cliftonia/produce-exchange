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
  u.postcode = rand(3000..3050)
  u.avatar = 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'
  u.availability = "mon, tues evenings, and weekends"
  u.save
end

statuses = ['pending', 'declined', 'accepted', 'completed']

statuses.each do |status|
  s = OfferStatus.new
  s.type = status
  s.save
end

items = ['apples', 'potatoes', 'tomatoes', 'peaches', 'lemons']
units = ['kg', 'g', 'pcs', '$']

5.times do
  i = Item.new
  i.title = items.sample
  i.quantity = rand(1..10)
  i.unit = units.sample
  i.user_id = rand(1..users.length)
  # i.offer_id = rand
  i.save
end

5.times do
  p = Photo.new
  p.item_id = rand(1..items.length)
  p.image_link = 'https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?v=1530129081'
  p.save
end


# o = Offer.new
# o.proposer_user_id =
# o.proposer_item_id  =
# o.proposer_item_qty =
# o.reviewer_user_id =
# o.reviewer_item_id =
# o.reviewer_item_qty =
# o.status_id =