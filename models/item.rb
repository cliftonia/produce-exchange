require 'geocoder'

class Item < ActiveRecord::Base
    extend Geocoder::Model::ActiveRecord
    reverse_geocoded_by :latitude, :longitude
    belongs_to :user
    has_many :proposer_offers, class_name: 'Offer', foreign_key: :proposer_item_id
    has_many :reviewer_offers, class_name: 'Offer', foreign_key: :reviewer_item_id
    has_many :photos

    # validates :title, presence: true
    # validates :qty, presence: true
    # validates :unit, presence: true
end