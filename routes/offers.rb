get '/offers/accepted/:id' do
  @offer = Offer.find(params[:id])
  if @offer.proposer_user_id == current_user.id
    @contact_username = @offer.reviewer_user.username
    @contact_availability = @offer.reviewer_user.availability
    @contact_email = @offer.reviewer_user.email
  else
    @contact_username = @offer.proposer_user.username
    @contact_availability = @offer.proposer_user.availability
    @contact_email = @offer.proposer_user.email
  end
  erb :offers_accepted_show
end

put '/offers/complete/:id' do
  offer = Offer.find(params[:id])
  offer.status_id = 4
  offer.save
  redirect '/offers/accepted'
end

get '/offers/accepted' do
  @my_offers = Offer.where("proposer_user_id = ? OR reviewer_user_id = ?", current_user.id, current_user.id)
  erb :offers_accepted
end

get '/offers' do
  @offers = Offer.all
  @proposer_offers = Offer.where( {proposer_user_id: current_user.id, status_id: 1})
  @reviewer_offers = Offer.where( {proposer_user_id: current_user.id, status_id: 1})
  erb :offer_review
end

get '/api/offers' do
  content_type :json
  @offers = Offer.all
  @proposer_offers = Offer.where(proposer_user_id: current_user.id)
  {offers: @proposer_offers}.to_json
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
    binding.pry
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
    o.meeting_point_suburb = current_user.suburb
  elsif params[:meeting_point] == 'theirs'
    o.meeting_point = User.find(o.reviewer_user_id).address_line_1
    o.meeting_point_suburb = User.find(o.reviewer_user_id).suburb
  end
  o.status_id = 1
  o.save
  redirect "/offers"
end

get '/offer/:id' do
  @offer = Offer.find(params[:id])
  @status = OfferStatus.find(@offer.status_id).stage
  proposed_user_id = @offer.proposer_item.user_id
  @photos = Photo.where(item_id: @offer.proposer_item.id)
  erb :offer_confirm
end

put '/offers/:id/update' do
  offer = Offer.find(params[:id])
  status = params[:status]
  proposer_item = offer.proposer_item
  reviewer_item = offer.reviewer_item
  prop_total = offer.proposer_item.quantity - offer.proposer_item_qty
  rev_total = offer.reviewer_item.quantity - offer.reviewer_item_qty
  if prop_total > 0 || rev_total > 0
    if params[:status] == 'accepted'
      offer.status_id = 3
      proposer_item.quantity = prop_total
      reviewer_item.quantity = rev_total
      proposer_item.save
      reviewer_item.save
    elsif params[:status] == 'declined'
      offer.status_id = 2
      Offer.delete(offer.id)
    end
    offer.save
    redirect '/offers'
  else
    @error_messages = "You don't have enough in your inventory"
    erb :offer_review
  end
end
