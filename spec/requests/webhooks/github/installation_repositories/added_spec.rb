# frozen_string_literal: true

require 'rails_helper'

describe 'Webhooks - Github - InstallationRepositories - added', type: :request do
  let(:headers) do
    {
      CONTENT_TYPE: 'application/json',
      HTTP_X_GITHUB_EVENT: 'installation_repositories'
    }
  end

  let(:request_body) do
    Rails.root.join('spec', 'fixtures', 'files', 'webhooks', 'github', 'installation_repositories', 'added.json').read
  end

  subject do
    post webhooks_github_index_url(subdomain: :webhooks), params: request_body, headers: headers
  end

  context 'Install is present in the system' do
    let!(:install) { create(:install, :with_user) }

    it do
      expect { subject }.to change(GithubRepository, :count).from(0).to(1)
    end
  end
end
