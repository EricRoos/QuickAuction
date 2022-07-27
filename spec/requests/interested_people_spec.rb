# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'InterestedPeople', type: :request do
  describe 'POST /intersted_people' do
    subject { response }
    context 'when the email has not been registered' do
      before do
        post interested_people_path, params: { interested_person: { email: 'foo@bar.com' } }
      end
      it { is_expected.to have_http_status(302) }
      describe 'the changed data' do
        subject { InterestedPerson.find_by_email('foo@bar.com') }
        it { is_expected.to_not be_nil }
      end
    end

    context 'when it fails to save' do
      before do
        allow_any_instance_of(InterestedPerson).to receive(:save).and_return(false)
        post interested_people_path, params: { interested_person: { email: 'foo@bar.com' } }
      end
      it { is_expected.to have_http_status(302) }
      describe 'the changed data' do
        subject { InterestedPerson.find_by_email('foo@bar.com') }
        it { is_expected.to be_nil }
      end
    end
  end
end
