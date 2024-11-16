require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "Relationship Rules:" do
    let(:anunciador) { create(:user) }
    let(:interested) { create(:user, :cpf_alternativo) }
    let(:advertisement) { create(:advertisement, user: anunciador) }
    let(:negotiation) { create(:negotiation, user: interested, advertisement: advertisement) }

    context "When creating an Review in the database," do
      it "must be possible to associate the Review with 1 User." do
        review1 = create(:review, user: interested, negotiation: negotiation)

        expect(interested.id).to eq(review1.user.id)
      end

      it "must be possible to associate the Review with 1 Advertisement." do
        review1 = create(:review, user: interested, negotiation: negotiation)

        expect(negotiation.id).to eq(review1.negotiation.id)
      end

      it "must be mandatory to have an associated User model object" do
        expect { create(:review) }.to raise_error(/User must exist/)
      end

      it "must be mandatory to have an associated Advertisement model object" do
        expect { create(:review) }.to raise_error(/Negotiation must exist/)
      end
    end
  end
end
