require 'rails_helper'

	describe 'creating posts on a profile' do
		before do
			@event = create(:event)
		end
		context 'no posts' do 
			it 'displays a message when there are no posts' do 
				visit event_path(@event)
				expect(page).to have_content 'There are no posts'
			end
		end
		context 'with posts' do
			before do
				post = create(:post, event: @event)
			end
			it ' displays posts if there any' do
				visit event_path(@event)
				expect(page).to have_content 'Run Roger'
			end
		end
	end