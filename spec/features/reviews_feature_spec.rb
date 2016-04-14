require 'rails_helper'

  feature 'reviewing' do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      Restaurant.create name: 'KFC'
    end


    scenario 'allow the user to leave a review using the form' do
      visit '/restaurants'
      binding.pry
      click_link 'Review KFC'
      fill_in 'Thoughts', with: 'so so'
      select '3', from: "Rating"
      click_button 'Leave Review'

      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('so so')

    end

    scenario 'users can only review a restaurant once' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: 'so so'
      select '3', from: "Rating"
      click_button 'Leave Review'
      visit '/restaurants'
      expect(page).not_to have_link('Review KFC')
    end
end
