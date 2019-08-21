class Offer < ActiveRecord::Base
    has_one :offer_status
    belongs_to :user
    belongs_to :proposer_item, class_name: 'Item'
    belongs_to :reviewer_item, class_name: 'Item'

    # validates :proposer_user_id, presence: true
    # validates :proposer_item_id, presence: true
    # validates :proposer_item_qty, presence: true
    # validates :reviewer_user_id, presence: true
    # validates :reviewer_item_id, presence: true
    # validates :reviewer_item_id, presence: true
    # validates :status_id, presence: true
end