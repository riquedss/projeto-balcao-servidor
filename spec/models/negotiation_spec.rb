require 'rails_helper'

RSpec.describe Negotiation, type: :model do
  describe "Relationship Rules:" do
    let(:advertisement_owner) { create(:user) }
    let(:interested) { create(:user, :cpf_alternativo) }
    let(:advertisement) { create(:advertisement, user: advertisement_owner) }

    context "When creating a Negotiation in the database," do
      it "must be possible to associate the Negotiation with 1 User." do
        negotiation = create(:negotiation, user: interested, advertisement: advertisement)
        expect(negotiation.user).to eq(interested)
      end

      it "must be possible to associate the Negotiation with 1 Advertisement." do
        negotiation = create(:negotiation, user: interested, advertisement: advertisement)
        expect(negotiation.advertisement).to eq(advertisement)
      end

      it "must not allow a user to negotiate their own advertisement" do
        expect {
          create(:negotiation, user: advertisement_owner, advertisement: advertisement)
        }.to raise_error(ActiveRecord::RecordInvalid, /You cannot negotiate with your own advertisement./)
      end

      it "must be mandatory to have an associated User model object" do
        expect {
          create(:negotiation, user: nil, advertisement: advertisement)
        }.to raise_error(ActiveRecord::RecordInvalid, /User must exist/)
      end

      it "must be mandatory to have an associated Advertisement model object" do
        expect {
          create(:negotiation, user: interested, advertisement: nil)
        }.to raise_error(ActiveRecord::RecordInvalid, /Advertisement must exist/)
      end
    end

    context "When updating a Negotiation," do
      let(:negotiation) { create(:negotiation, user: interested, advertisement: advertisement) }

      it "must allow confirmation" do
        negotiation.update!(status: :pending)
        expect {
          negotiation.confirm!
        }.to change { negotiation.reload.status }.from("pending").to("confirmed")
      end
    end

    context "When completing a Negotiation," do
      let(:negotiation) { create(:negotiation, user: interested, advertisement: advertisement, status: :confirmed) }

      it "must allow completion if the negotiation is confirmed" do
        expect {
          negotiation.complete!
        }.to change { negotiation.reload.status }.from("confirmed").to("completed")
      end

      it "must not allow completion if the negotiation is not confirmed" do
        negotiation.update!(status: :pending)
        expect {
          negotiation.complete!
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "When deleting a Negotiation from the database," do
      let(:negotiation) { create(:negotiation, user: interested, advertisement: advertisement) }

      it "all associated objects must be deleted if they are of the Review model." do
        review = create(:review, user: interested, negotiation: negotiation)
        negotiation.destroy
        expect { Review.find(review.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
