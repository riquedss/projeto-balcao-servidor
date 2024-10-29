require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "Relationship Rules:" do
    let(:anunciador) { create(:user) }
    let(:interested) { create(:user) }
    let(:advertisement) { create(:advertisement, user: anunciador) }

    context "When creating an message in the database," do
      it "must be possible to associate the message with 1 User." do
        message1 = create(:message, user: interested, advertisement: advertisement)

        expect(interested.id).to eq(message1.user.id)
      end

      it "must be possible to associate the message with 1 Advertisement." do
        message1 = create(:message, user: interested, advertisement: advertisement)

        expect(advertisement.id).to eq(message1.advertisement.id)
      end

      it "must be mandatory to have an associated User model object" do
        expect { create(:message) }.to raise_error(/User must exist/)
      end

      it "must be mandatory to have an associated Advertisement model object" do
        expect { create(:message) }.to raise_error(/Advertisement must exist/)
      end
    end
  end
end
