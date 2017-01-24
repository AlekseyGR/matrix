# frozen_string_literal: true
require 'rails_helper'

RSpec.describe API do
  describe 'GET /api/routes' do
    let(:route) { FactoryGirl.create(:route) }

    before do
      20.times do
        FactoryGirl.create(:route)
      end

      get '/api/routes', params: params
    end

    context 'with correct passphrase' do
      let(:params) { { passphrase: Rails.application.secrets.passphrase, source: route.source } }

      it 'returns 200 status' do
        expect(response.status).to eq(200)
      end

      it 'returns storaged data' do
        result = Route.where(source: route.source)
        expect(response.body).to include(result.to_json)
      end
    end

    context 'with wrong passphrase' do
      let(:params) { { passphrase: 'foo' } }

      it 'returns 401 status' do
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'POST /api/routes' do
    before do
      post '/api/routes', params: params
    end

    context 'with valid params' do
      let(:params) do
        {
          passphrase: Rails.application.secrets.passphrase,
          source: Route::SOURCES.sample,
          start_node: Route::NODES.sample,
          end_node: Route::NODES.sample,
          start_date: DateTime.now,
          end_date: DateTime.now + 1.hour
        }
      end

      it 'creates new route' do
        expect(Route.count).to eq(1)
      end

      it 'returns 201 status' do
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid passphrase' do
      let(:params) do
        {
          passphrase: 'foo',
          source: Route::SOURCES.sample,
          start_node: Route::NODES.sample,
          end_node: Route::NODES.sample,
          start_date: DateTime.now,
          end_date: DateTime.now + 1.hour
        }
      end

      it 'creates no route' do
        expect(Route.count).to eq(0)
      end

      it 'returns 401 status' do
        expect(response.status).to eq(401)
      end
    end

    context 'with invalid source' do
      let(:params) do
        {
          passphrase: Rails.application.secrets.passphrase,
          source: 'foo',
          start_node: Route::NODES.sample,
          end_node: Route::NODES.sample,
          start_date: DateTime.now,
          end_date: DateTime.now + 1.hour
        }
      end

      it 'creates no route' do
        expect(Route.count).to eq(0)
      end

      it 'returns 400 status' do
        expect(response.status).to eq(400)
      end
    end

    context 'with invalid start_node' do
      let(:params) do
        {
          passphrase: Rails.application.secrets.passphrase,
          source: Route::SOURCES.sample,
          start_node: 'foo',
          end_node: Route::NODES.sample,
          start_date: DateTime.now,
          end_date: DateTime.now + 1.hour
        }
      end

      it 'creates no route' do
        expect(Route.count).to eq(0)
      end

      it 'returns 400 status' do
        expect(response.status).to eq(400)
      end
    end

    context 'with invalid end_node' do
      let(:params) do
        {
          passphrase: Rails.application.secrets.passphrase,
          source: Route::SOURCES.sample,
          start_node: Route::NODES.sample,
          end_node: 'foo',
          start_date: DateTime.now,
          end_date: DateTime.now + 1.hour
        }
      end

      it 'creates no route' do
        expect(Route.count).to eq(0)
      end

      it 'returns 400 status' do
        expect(response.status).to eq(400)
      end
    end

    context 'with invalid start_date' do
      let(:params) do
        {
          passphrase: Rails.application.secrets.passphrase,
          source: Route::SOURCES.sample,
          start_node: Route::NODES.sample,
          end_node: Route::NODES.sample,
          start_date: 'foo',
          end_date: DateTime.now + 1.hour
        }
      end

      it 'creates no route' do
        expect(Route.count).to eq(0)
      end

      it 'returns 400 status' do
        expect(response.status).to eq(400)
      end
    end

    context 'with invalid end_date' do
      let(:params) do
        {
          passphrase: Rails.application.secrets.passphrase,
          source: Route::SOURCES.sample,
          start_node: Route::NODES.sample,
          end_node: Route::NODES.sample,
          start_date: DateTime.now,
          end_date: 'foo'
        }
      end

      it 'creates no route' do
        expect(Route.count).to eq(0)
      end

      it 'returns 400 status' do
        expect(response.status).to eq(400)
      end
    end
  end
end
