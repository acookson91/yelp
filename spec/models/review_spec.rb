require 'rails_helper'

RSpec.describe Review, type: :model do

  let(:kfc) { Restaurant.create name: 'KFC' }

  it { is_expected.to belong_to :restaurant }

  describe 'kfc ' do
    it 'should delete review when kfc is deleted' do
      review = Review.create(thoughts: 'haha', rating:1)
      review.user = User.new
      kfc.reviews << review
      expect{kfc.destroy}.to change{Review.count}
    end
  end

  it "is invalid if the rating is more than 5" do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end

end
