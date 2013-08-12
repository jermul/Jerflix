require 'spec_helper'

describe UserSignup do 
  describe "#sign_up" do
    context "valid personal info and valid credit card" do
      let(:charge) { double(:charge, successful?: true) }

      before do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end

      after { ActionMailer::Base.deliveries.clear }

      it "creates the user" do
        UserSignup.new(Fabricate.build(:user)).sign_up("some_stripe_token", nil)
        expect(User.count).to eq(1)
      end

      it "makes the user follow the inviter" do
        jim = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: jim, recipient_email: 'joe@example.com')
				UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).sign_up("some_stripe_token", invitation.token)        
				joe = User.where(email: 'joe@example.com').first
        expect(joe.follows?(jim)).to be_true
      end

      it "makes the inviter follow the user" do
        jim = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: jim, recipient_email: 'joe@example.com')
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).sign_up("some_stripe_token", invitation.token)
        joe = User.where(email: 'joe@example.com').first
        expect(jim.follows?(joe)).to be_true
      end
      
      it "expires the invitation upon acceptance" do
        jim = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: jim, recipient_email: 'joe@example.com')
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).sign_up("some_stripe_token", invitation.token)
        joe = User.where(email: 'joe@example.com').first
        expect(Invitation.first.token).to be_nil
      end

      it "sends out email containing the user's name with valid inputs" do
      	UserSignup.new(Fabricate.build(:user, email: 'john@example.com', full_name: "John Doe")).sign_up("some_stripe_token", nil)
        expect(ActionMailer::Base.deliveries.last.body).to include('John Doe')
      end

      it "sends out email to the user with valid inputs" do
      	UserSignup.new(Fabricate.build(:user, email: 'john@example.com')).sign_up("some_stripe_token", nil)
        expect(ActionMailer::Base.deliveries.last.to).to eq(['john@example.com'])
      end
    end

    context "with valid personal info but declined credit card" do
      it "does not create a new user record" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        UserSignup.new(Fabricate.build(:user)).sign_up('123123', nil)
        expect(User.count).to eq(0)
      end
    end

    context "with invalid personal info" do
      before do
        UserSignup.new(User.new(email: 'joe@example.com')).sign_up('123123', nil)
      end

      after { ActionMailer::Base.deliveries.clear }
      
      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "does not charge the credit card" do
        StripeWrapper::Charge.should_not_receive(:create)
      end

      it "does not send out email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end