require 'rails_helper'

  feature 'reviewing' do
    doubles

    before do
      sign_up(email, password)
      Restaurant.create name: 'KFC'
    end

    scenario 'allow the user to leave a review using the form' do
      leave_review('soso', '3')
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('soso')
    end

    scenario 'users can only review a restaurant once' do
      leave_review('soso', '3')
      visit '/restaurants'
      expect(page).not_to have_link('Review KFC')
    end

    scenario 'displays an average rating for all reviews' do
      leave_review('So so', '3')
      click_link 'Sign out'
      sign_up(email2, password)
      leave_review('Great', '5')
      expect(page).to have_content('Average rating: ★★★★☆')
    end
end
