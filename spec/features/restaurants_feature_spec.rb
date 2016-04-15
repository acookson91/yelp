require 'rails_helper'

feature 'restaurants' do
  doubles

  before do
    sign_up(email, password)
  end

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      restaurant = Restaurant.new(name: 'KFC')
      restaurant.user = User.first
      restaurant.save
    end

    scenario 'display restaurants' do
      visit '/'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      create_restaurant(name)
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invaild restaurant' do
      it 'does not let you submit a name that is too short' do
        create_restaurant('kf')
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do
    let!(:kfc) { Restaurant.create(name: 'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before do
      restaurant = Restaurant.new(name: 'KFC')
      restaurant.user = User.first
      restaurant.save
    end

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    before do
      restaurant = Restaurant.new(name: 'KFC')
      restaurant.user = User.first
      restaurant.save
    end

    scenario 'User can delete restaurant' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted sucessfully'
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'Not signed in' do
    before do
      Restaurant.create name: 'KFC'
      visit '/'
      click_link 'Sign out'
    end

    scenario 'User cannot add restaurant' do
      visit '/'
      click_link 'Add a restaurant'
      expect(page).not_to have_button 'Create Restaurant'
      expect(page).to have_button('Log in')
    end

    scenario 'User cannot edit restaurant' do
      visit '/'
      expect(page).not_to have_button 'Update Restaurant'
    end
  end

  context 'Not my restaurant' do
    before do
      create_restaurant(name)
      click_link 'Sign out'
      sign_up(email2, password)
    end

    scenario 'Cannot edit/delete restaurant' do
      visit '/'
      expect(page).not_to have_link 'Edit KFC'
      expect(page).not_to have_link 'Delete KFC'
    end
  end
end
