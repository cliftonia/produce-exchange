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

get '/offer/:id' do
  @offer = Offer.find(params[:id])
  @status = OfferStatus.find(@offer.status_id).stage
  proposed_user_id = @offer.proposer_item.user_id
  @photos = Photo.where(item_id: @offer.proposer_item.id)
  # binding.pry

  # here will be the details of the offer with accept or decline
  # change the status depending on the action
  erb :offer_confirm
  # "hey"
end

post '/api/offer_status' do
  content_type :json
  offer = Offer.find(params[:offer_id])
  offer_status = OfferStatus.find(offer.status_id)
  if params[:class_name].include? 'accept'
    offer.status_id = 3
  elsif params[:class_name].include? 'decline'
    offer.status_id = 2
  end
  if offer.save
    { message: 'Record saved!',
      offer_status: OfferStatus.find(offer.status_id).stage,
    }.to_json
  end

end
