# params need to be sent from the items page
get '/offers/:item_id' do
  @proposed_items = Item.where(user_id: current_user.id)
  @reviewer_item = Item.find(params[:item_id])
  @photos = Photo.where(item_id: params[:item_id])
  erb :offers_new
end

post '/offers/new' do
  o = Offer.new
  o.proposer_user_id = current_user.id
  o.proposer_item_id = Item.find(params[:item_id])
  o.proposer_item_qty = Item.find(params[:qty])
  o.reviewer_user_id = Item.find(params[:reviewer_item_id]).user_id
  o.reviewer_item_id = Item.find(params[:reviewer_item_id])
  if params[:meeting_point] == 'yours'
    o.meeting_point = "#{current_user.address_line_1}, #{current_user.suburb}"
  elsif params[:meeting_point] == 'theirs'
    o.meeting_point = "#{User.find(o.reviewer_user_id).address_line_1}, #{User.find(o.reviewer_user_id).suburb}"
  elsif params[:meeting_point] == 'elsewhere'
    o.meeting_point = params[:elsewhere]
  end
  o.status_id = 1
  o.save
  redirect "/offers/#{params[:item_id]}"
  # redirect to a transactions page
end