require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  describe "Relationship Rules:" do
    let(:anunciador) { create(:user) }
    let(:interested) { create(:user) }
    let(:advertisement) { create(:advertisement, user: anunciador) }
    # let(:negotiation) { create(:negotiation, user: anunciador, advertisement: advertisement) }

    context "When creating an advertisement in the database," do
      it "must be possible to associate the advertisement with 1 User." do
        advertisement1 = create(:advertisement, user: anunciador)

        expect(anunciador.id).to eq(advertisement1.user.id)
      end

      it "must be mandatory to have an associated user model object" do
        expect { create(:advertisement) }.to raise_error(/User must exist/)
      end
    end

    context "When persisting a advertisement in the database," do
      it "must be possible to associate the advertisement with N Messages." do
        message1 = create(:message, user: interested, advertisement: advertisement)
        message2 = create(:message, user: interested, advertisement: advertisement)
        message3 = create(:message, user: interested, advertisement: advertisement)

        associated_objects = advertisement.messages

        expect([ message1.id, message2.id, message3.id ]).to match_array(associated_objects.ids)
      end

      it "must be possible to associate the advertisement with N Transactions." do
        negotiation1 = create(:negotiation, user: interested, advertisement: advertisement)
        negotiation2 = create(:negotiation, user: interested, advertisement: advertisement)
        negotiation3 = create(:negotiation, user: interested, advertisement: advertisement)

        associated_objects = advertisement.negotiations

        expect([ negotiation1.id, negotiation2.id, negotiation3.id ]).to match_array(associated_objects.ids)
      end
    end

    context "When deleting a advertisement from the database," do
      it "must be possible to delete the Ad if associated with some object of the Message model." do
        create(:message, user: interested, advertisement: advertisement)

        expect { advertisement.destroy }.to raise_error(ActiveRecord::DeleteRestrictionError)
      end

      it "should not be possible if it is associated with some object of the Negotiation model." do
        create(:negotiation, user: interested, advertisement: advertisement)

        expect { advertisement.destroy }.to raise_error(ActiveRecord::DeleteRestrictionError)
      end

      it "must be possible to delete the Ad if associated with some object of the User model" do
        advertisement.destroy

        expect { Advertisement.find(advertisement.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
