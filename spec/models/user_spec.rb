require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Relationship Rules:" do
    let(:anunciador) { create(:user) }
    let(:interested) { create(:user, :cpf_alternativo) }
    let(:advertisement) { create(:advertisement, user: anunciador) }
    let(:negotiation) { create(:negotiation, user: anunciador, advertisement: advertisement) }

    context "When persisting a user in the database," do
      it "must be possible to associate the user with N Advertisements." do
        advertisement1 = create(:advertisement, user: anunciador)
        advertisement2 = create(:advertisement, user: anunciador)
        advertisement3 = create(:advertisement, user: anunciador)

        associated_objects = anunciador.advertisements

        expect([ advertisement1.id, advertisement2.id, advertisement3.id ]).to match_array(associated_objects.ids)
      end

      it "must be possible to associate the user with N Messages." do
        message1 = create(:message, user: interested, advertisement: advertisement)
        message2 = create(:message, user: interested, advertisement: advertisement)
        message3 = create(:message, user: interested, advertisement: advertisement)

        associated_objects = interested.messages

        expect([ message1.id, message2.id, message3.id ]).to match_array(associated_objects.ids)
      end

      it "must be possible to associate the user with N Negotiations." do
        negotiation1 = create(:negotiation, user: interested, advertisement: advertisement)
        negotiation2 = create(:negotiation, user: interested, advertisement: advertisement)
        negotiation3 = create(:negotiation, user: interested, advertisement: advertisement)

        associated_objects = interested.negotiations

        expect([ negotiation1.id, negotiation2.id, negotiation3.id ]).to match_array(associated_objects.ids)
      end

      it "must be possible to associate the user with N Reviews." do
        review1 = create(:review, user: interested, negotiation: negotiation)
        review2 = create(:review, user: interested, negotiation: negotiation)
        review3 = create(:review, user: interested, negotiation: negotiation)

        associated_objects = interested.reviews

        expect([ review1.id, review2.id, review3.id ]).to match_array(associated_objects.ids)
      end
    end

    context "When deleting a user from the database," do
      it "all associated objects must be deleted if they are of the Advertisement model." do
        advertisement1 = create(:advertisement, user: anunciador)

        anunciador.destroy

        expect { Advertisement.find(advertisement1.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "all associated objects must be deleted if they are of the Review model." do
        review1 = create(:review, user: interested, negotiation: negotiation)

        interested.destroy

        expect { Review.find(review1.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should not be possible if it is associated with some object of the Message model." do
        create(:message, user: interested, advertisement: advertisement)

        expect { interested.destroy }.to raise_error(ActiveRecord::DeleteRestrictionError)
      end

      it "should not be possible if it is associated with some object of the Negotiation model." do
        create(:negotiation, user: interested, advertisement: advertisement)

        expect { interested.destroy }.to raise_error(ActiveRecord::DeleteRestrictionError)
      end
    end
  end
end
