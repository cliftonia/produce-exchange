get '/items/new' do

  erb :item_new
end

get '/api/items' do
  content_type :json
  item_details = Item.find(params[:item_id])
  {
    item_qty: item_details.quantity,
    item_units: item_details.unit
  }.to_json
end

post '/items' do
  item = Item.new
  item.title = params[:title]
  item.description = params[:description]
  item.quantity = params[:quantity]
  item.unit = params[:unit]
  item.user_id = current_user.id
  item.latitude = current_user.lat
  item.longitude = current_user.lon
  item.save

  photo = Photo.new
  photo.image_link = params[:image_link]
  photo.item_id = item.id
  photo.save

  redirect "/items/#{item.id}"
end

get '/items/:id' do

  @item = Item.find(params[:id])

  @photos = @item.photos

  erb :item_show
end

get '/items/:id/edit' do
  @item = Item.find(params[:id])
  @photos = @item.photos
  erb :item_edit
end

put '/items/:id' do

  item = Item.find(params[:id])
  item.title = params[:title]
  item.description = params[:description]
  item.quantity = params[:quantity]
  item.latitude = current_user.lat
  item.longitude = current_user.lon

  item.unit = params[:unit]
  item.save

  # photo = Photo.find_by(item_id: params[:id])

  # photo.image_link = params[:image_link]

  # photo.save

  redirect "/items/#{item.id}"
end

delete '/items/:id' do
  @item = Item.find(params[:id])

  @photo = Photo.find_by(item_id: params[:id])
  @photo.delete

  @item.delete
  redirect "/"
end
