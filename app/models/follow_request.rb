class FollowRequest < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :recipient_id, :presence => true

  validates :sender_id, :presence => true

end
