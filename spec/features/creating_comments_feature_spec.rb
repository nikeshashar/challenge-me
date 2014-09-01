require 'rails_helper'

describe 'leaving comments' do
  before do
      @mary = create(:user)
      @event = create(:event, user: @mary)
      post = create(:post, event: @event, user: @mary)
    end

    context 'as a logged in user' do
      before do
        login_as @mary
      end

      it 'allows me to comment on a post' do
        visit event_path(@event)
        fill_in 'Comments', with: 'Great challenge!!'
        click_button('Submit')
        expect(page).to have_content 'Great challenge!!'
      end

      it 'gives an error if comment is posted with invalid data' do
        visit event_path(@event)
        fill_in 'Comments', with: 'a'
        click_button('Submit')
        expect(page).to have_content 'Comments needs to between 3 and 140 characters'
      end
    end

    context 'as a logged out user' do
      it 'should prompt me to sign in' do
        visit event_path(@event)
        fill_in 'Comments', with: 'Great challenge!!'
        click_button('Submit')
        expect(page).to have_content 'Log in'
      end
    end
end