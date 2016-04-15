def doubles
  let(:email) { 'test@example.com' }
  let(:email2) { 'test2@example.com' }
  let(:password) { 'testtest' }
  let(:name) { 'KFC' }
end

def create_restaurant(name)
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: name
  click_button 'Create Restaurant'
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
end
