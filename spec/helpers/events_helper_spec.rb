require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the EventsHelper. For example:
#
# describe EventsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe EventsHelper, :type => :helper do

	describe 'event countdown' do
		before(:each) do
			user = create(:user)
			@race = create(:event, user: user)
		end

		it 'provides a countdown of the number of days remaining' do
			Timecop.freeze(Time.local(2014, 9, 1, 10, 5, 0)) do
				visit event_path(@race)
				expect(page).to have_content("Days to go: 11")
			end
		end

		it 'displays "Event Day" on day of event' do
			Timecop.freeze(Time.local(2014, 9, 12, 10, 5, 0)) do
				visit event_path(@race)
				expect(page).to have_content("Today's the day!")
			end
		end

		it 'displays "Event Complete" after event date' do
			Timecop.freeze(Time.local(2014, 9, 14, 10, 5, 0)) do
				visit event_path(@race)
				expect(page).to have_content("Event completed 2 days ago!")
			end
		end

	end

	describe 'percentage of fundraising target achieved' do
		before(:each) do
			@user = create(:user)
		end

		it 'when the target has not been reached it provides a percentage of the amount raised' do
			@race = create(:event, user: @user)
      visit event_path(@race)
			expect(page).to have_content("Percentage complete: 1%")
		end

		it 'when the target has been reached it displays the exceeded percentage' do
			@marathon = create(:event, amount_raised: 1100.0, user: @user)
			visit event_path(@marathon)
			expect(page).to have_content("Percentage complete: 110%")
		end
	end
end
