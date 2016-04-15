require 'rails_helper'

  feature 'reviewing' do
    let(:email) { 'test@example.com' }
    let(:email2) { 'test2@example.com' }


    let(:password) { 'testtest' }

    before do
      sign_up(email, password)
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
      expect(page).to have_content('Average rating: 4')
    end

    def leave_review(thoughts, rating)
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: thoughts
      select rating, from: 'Rating'
      click_button 'Leave Review'
    end


    def sign_up(email, password)
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: email)
      fill_in('Password', with: password)
      fill_in('Password confirmation', with: password)
      click_button('Sign up')
      Restaurant.create name: 'KFC'
    end


end
