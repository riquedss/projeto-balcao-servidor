require 'rails_helper'

RSpec.describe Negotiation, type: :model do
  describe "Relationship Rules:" do
    let(:anunciador) { create(:user) }
    let(:interested) { create(:user) }
    let(:advertisement) { create(:advertisement, user: anunciador) }
    let(:negotiation) { create(:negotiation, user: anunciador, advertisement: advertisement) }

    context "When creating an Negotiation in the database," do
      it "must be possible to associate the Negotiation with 1 User." do
        negotiation1 = create(:negotiation, user: interested, advertisement: advertisement)

        expect(interested.id).to eq(negotiation1.user.id)
      end

      it "must be possible to associate the Negotiation with 1 Advertisement." do
        negotiation1 = create(:negotiation, user: interested, advertisement: advertisement)

        expect(advertisement.id).to eq(negotiation1.advertisement.id)
      end

      it "must be mandatory to have an associated User model object" do
        expect { create(:negotiation) }.to raise_error(/User must exist/)
      end

      it "must be mandatory to have an associated Advertisement model object" do
        expect { create(:negotiation) }.to raise_error(/Advertisement must exist/)
      end
    end

    context "When persisting a Negotiation in the database," do
      it "must be possible to associate the user with N Reviews." do
        review1 = create(:review, user: interested, negotiation: negotiation)
        review2 = create(:review, user: interested, negotiation: negotiation)
        review3 = create(:review, user: interested, negotiation: negotiation)

        associated_objects = negotiation.reviews

        expect([ review1.id, review2.id, review3.id ]).to match_array(associated_objects.ids)
      end
    end

    context "When deleting a Negotiation from the database," do
      it "all associated objects must be deleted if they are of the Review model." do
        review1 = create(:review, user: interested, negotiation: negotiation)

        negotiation.destroy

        expect { Review.find(review1.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
