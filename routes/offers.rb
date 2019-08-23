get '/offers/accepted' do
  @offers = Offer.all
  erb :offers_accepted
end

get '/offers' do
  @offers = Offer.all
  @proposer_offers = Offer.where(proposer_user_id: current_user.id)
  @reviewer_offers = Offer.where(reviewer_user_id: current_user.id)
  erb :offer_review
end

get '/offers/:id/edit' do
  @offer = Offer.find(params[:id])
  erb :offer_edit
end

get '/offers/:item_id' do
  @proposed_items = Item.where(user_id: current_user.id)
  @reviewer_item = Item.find(params[:item_id])
  @photos = Photo.where(item_id: params[:item_id])
  erb :offer_new
end

put '/offers/:id' do
  edit = Offer.find(params[:id])
  edit.proposer_item_qty = params[:quantity]
  if edit.save
    redirect "/offers"
  else
    'not saved'
  end
end

delete '/offers/:id' do
  Offer.delete(params[:id])
  redirect "/offers/#{params[:id]}"
end

post '/offers/new' do
  o = Offer.new
  o.proposer_user_id = current_user.id
  o.proposer_item_id = Item.find(params[:item_id]).id
  o.proposer_item_qty = params[:qty]
  o.reviewer_user_id = Item.find(params[:reviewer_item_id]).user_id
  o.reviewer_item_id = Item.find(params[:reviewer_item_id]).id
  o.reviewer_item_qty = Item.find(params[:reviewer_item_id]).quantity
  if !params[:elsewhere].empty?
    o.meeting_point = params[:elsewhere]
  elsif params[:meeting_point] == 'yours'
    o.meeting_point_suburb = current_user.address_line_1
    o.meeting_point_suburb = current_user.suburb#{current_user.suburb}"
  elsif params[:meeting_point] == 'theirs'
    o.meeting_point = User.find(o.reviewer_user_id).address_line_1
    o.meeting_point_suburb = User.find(o.reviewer_user_id).suburb
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
  erb :offer_confirm
end

post '/api/offer_status' do
  content_type :json
  offer = Offer.find(params[:offer_id])
  offer_status = OfferStatus.find(offer.status_id)
  prop_item = Item.find(offer.proposer_item_id)
  rev_item = Item.find(offer.reviewer_item_id)
  if params[:class_name].include? 'accept'
    offer.status_id = 3
    prop_item_qty = offer.proposer_item.quantity - offer.proposer_item_qty
    rev_item_qty = offer.reviewer_item.quantity - offer.reviewer_item_qty
    prop_item.save
    rev_item.save
  elsif params[:class_name].include? 'decline'
    offer.status_id = 2
    Offer.delete(offer.id)
  end
  if offer.save
    { message: 'Record saved!',
      offer_status: OfferStatus.find(offer.status_id).stage,
    }.to_json
  end
end
