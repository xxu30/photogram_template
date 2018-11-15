class Photo < ApplicationRecord
  # Direct associations

  has_many   :comments,
             :dependent => :destroy

  has_many   :likes,
             :dependent => :destroy

  belongs_to :owner,
             :class_name => "User",
             :counter_cache => :own_photos_count

  # Indirect associations

  has_many   :followers,
             :through => :owner,
             :source => :following

  has_many   :fan_followers,
             :through => :fans,
             :source => :following

  # Validations

  validates :image, :presence => true

  validates :owner_id, :presence => true

end
