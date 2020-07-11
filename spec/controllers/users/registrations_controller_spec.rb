require 'rails_helper'

describe Users::RegistrationsController do
  let(:user) { FactoryBot.create(:user) }

  setup do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'GET #new' do
    it "new.html.erbに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it "@sendingDestinationに正しい値が入っていること" do
      
    end
  end

  describe 'GET #newSendingDestination' do
    it "newSendingDestination.html.erbに遷移すること" do
      get :newSendingDestination
      expect(response).to render_template :newSendingDestination
    end
  end

  describe 'POST #createSendingDestination' do
    let(:params) { { user_id: user.id, sending_destination: attributes_for(:sending_destination) } }
    it "@userに正しい値が入っていること" do
      
    end
    it "@sendingDestinationに正しい値が入っていること" do
      
    end
    it "createSendingDestination.html.erbに遷移すること" do
      # post :createSendingDestination, params: params
      # expect(response).to render_template :createSendingDestination
    end
  end

end