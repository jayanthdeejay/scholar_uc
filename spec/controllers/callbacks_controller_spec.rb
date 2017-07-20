# frozen_string_literal: true
require 'rails_helper'

describe CallbacksController do
  describe 'omniauth-orcid' do
    let(:uid) { 'sixplus2@test.com' }
    let(:provider) { :orcid }
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      omniauth_hash_orcid = { "provider": "orcid",
                              "uid": "0000-0003-2012-0010",
                              "info": {
                                "name": "John Smith",
                                "email": uid
                              },
                              "credentials": {
                                "token": "e82938fa-a287-42cf-a2ce-f48ef68c9a35",
                                "refresh_token": "f94c58dd-b452-44f4-8863-0bf8486a0071",
                                "expires_at": 1_979_903_874,
                                "expires": true
                              },
                              "extra": {
                              } }
      OmniAuth.config.add_mock(provider, omniauth_hash_orcid)
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
    end

    context 'with a user who is already logged in' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        allow(controller).to receive(:current_user) { user }
      end

      it 'redirects to catalog index path with success notice' do
        get provider
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to match(/You have successfully connected with your ORCID record/)
      end
    end
  end

  describe 'omniauth-shibboleth' do
    let(:provider) { :shibboleth }
    let(:uid) { 'sixplus2@test.com' }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      omniauth_hash = { provider: 'shibboleth',
                        uid: uid,
                        extra: {
                          raw_info: {
                            mail: uid,
                            title: 'title',
                            telephoneNumber: '123-456-7890',
                            givenName: 'Fake',
                            sn: 'User',
                            uceduPrimaryAffiliation: 'staff',
                            ou: 'department'
                          }
                        } }
      OmniAuth.config.add_mock(provider, omniauth_hash)
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
    end

    context 'with a user who is already logged in' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        controller.stub(:current_user).and_return(user)
      end
      it 'redirects to the dashboard' do
        get provider
        response.should redirect_to(Hyrax::Engine.routes.url_helpers.dashboard_index_path)
      end
    end

    shared_examples 'Shibboleth login' do
      before do
        allow(controller).to receive(:find_by_provider_and_uid).and_return(user)
      end

      it 'assigns the user and redirects' do
        get provider
        expect(flash[:notice]).to match(/You are now signed in as */)
        expect(assigns(:user)).to eq(user)
        expect(response).to be_redirect
      end
    end

    context 'with a brand new user' do
      let(:user) { FactoryGirl.create(:user, email: 'new.user@example.com') }
      it_behaves_like 'Shibboleth login'
    end

    context 'with a registered user who has previously logged in' do
      let(:user) { FactoryGirl.create(:shibboleth_user, count: 1) }
      it_behaves_like 'Shibboleth login'
    end

    context 'with a registered user who has never logged in' do
      let(:user) { FactoryGirl.create(:shibboleth_user, count: 0) }
      it_behaves_like 'Shibboleth login'
    end
  end
end
