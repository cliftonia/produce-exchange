get '/offers' do
  @offers = Offer.all
  @proposer_offers = Offer.where(proposer_user_id: current_user.id)
  @reviewer_offers = Offer.where(reviewer_user_id: current_user.id)
  erb :offer_review
end

# params need to be sent from the items page
get '/offers/:item_id' do
  @proposed_items = Item.where(user_id: current_user.id)
  @reviewer_item = Item.find(params[:item_id])
  @photos = Photo.where(item_id: params[:item_id])
  erb :offer_new
end

post '/offers/new' do
  o = Offer.new
  o.proposer_user_id = current_user.id
  o.proposer_item_id = Item.find(params[:item_id]).id
  o.proposer_item_qty = params[:qty]
  o.reviewer_user_id = Item.find(params[:reviewer_item_id]).user_id
  o.reviewer_item_id = Item.find(params[:reviewer_item_id]).id
  if !params[:elsewhere].empty?
    o.meeting_point = params[:elsewhere]
  elsif params[:meeting_point] == 'yours'
    o.meeting_point = "#{current_user.address_line_1}, #{current_user.suburb}"
  elsif params[:meeting_point] == 'theirs'
    o.meeting_point = "#{User.find(o.reviewer_user_id).address_line_1}, #{User.find(o.reviewer_user_id).suburb}"
  end
  o.status_id = 1
  o.save
  redirect "/offers"
  # redirect to a transactions page
end

