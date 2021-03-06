class Offer < ActiveRecord::Base
    belongs_to :status, class_name: 'OfferStatus', foreign_key: :status_id

    belongs_to :user
    belongs_to :proposer_item, class_name: 'Item'
    belongs_to :reviewer_item, class_name: 'Item'
    belongs_to :proposer_user, class_name: 'User'
    belongs_to :reviewer_user, class_name: 'User'

    # validates :proposer_user_id, presence: true
    # validates :proposer_item_id, presence: true
    # validates :proposer_item_qty, presence: true
    # validates :reviewer_user_id, presence: true
    # validates :reviewer_item_id, presence: true
    # validates :reviewer_item_id, presence: true
    # validates :status_id, presence: true
end