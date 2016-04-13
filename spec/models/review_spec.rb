require 'rails_helper'

RSpec.describe Review, type: :model do

  let(:kfc) { Restaurant.create name: 'KFC' }

  it { is_expected.to belong_to :restaurant }

  describe 'kfc ' do
    it 'should delete review when kfc is deleted' do
      review = Review.create(thoughts: 'haha', rating:1)
      kfc.reviews << review
      expect{kfc.destroy}.to change{Review.count}
    end
  end
end
