require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#rewards_sum' do
    let(:user) { create(:user) }
    let!(:reward1) { create(:reward, amount: 1000, user: user) }
    let!(:reward2) { create(:reward, amount: 2000, user: user) }
    let!(:reward3) { create(:reward, amount: 2000) }

    subject { user.rewards_sum }

    context 'reward_sum' do
      it 'Userが所持しているRewardの合計と同じ' do
        is_expected.to eq (reward1.amount + reward2.amount);
      end
    end
  end
end
