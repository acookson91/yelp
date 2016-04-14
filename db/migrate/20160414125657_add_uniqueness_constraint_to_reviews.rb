class AddUniquenessConstraintToReviews < ActiveRecord::Migration
  add_index  :reviews, [:user_id, :restaurant_id],
      :name => "udx_reviews_on_user_and_restaurant", :unique => true
end
