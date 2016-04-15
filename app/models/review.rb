class Review < ActiveRecord::Base
  include ReviewsHelper
  belongs_to :restaurant
  belongs_to :user
  validates :rating, inclusion: (1..5)
  validates :user_id, :uniqueness => { :scope => :restaurant,
    :message => 'Users may only review a restaurant once'}
end
