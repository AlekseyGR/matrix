# frozen_string_literal: true
class API < Grape::API
  version 'v1', using: :header, vendor: 'Matrix'
  format :json
  prefix :api

  helpers do
    def valid_passphrase
      return false unless params[:passphrase]
      passphrase = params[:passphrase]
      Rails.application.secrets.passphrase == passphrase
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless valid_passphrase
    end
  end

  resource :routes do
    before do
      authenticate!
    end

    desc 'Returns whatever we already collected'
    params do
      # requires :source, type: String, desc: 'Data source.', values: %w(sentinels sniffers loopholes)
    end
    get do
      result = Route.where(source: params[:source])
      present :per_page, 10
      present :routes, result, with: Entities::Route
    end

    desc 'Import the parsed data into our system.'
    params do
      requires :source, type: String, desc: 'Data source.', values: %w(sentinels sniffers loopholes)
      requires :start_node, type: String, desc: 'Start node.',
                            values: %w(alpha beta gamma delta theta lambda tau psi omega)
      requires :end_node, type: String, desc: 'End node.', values: %w(alpha beta gamma delta theta lambda tau psi omega)
      requires :start_date, type: DateTime, desc: 'Start date.',
                            coerce_with: ->(value) { DateTime.strptime(value, '%FT%T') }, allow_blank: false
      requires :end_date, type: DateTime, desc: 'End date.',
                          coerce_with: ->(value) { DateTime.strptime(value, '%FT%T') }, allow_blank: false
    end
    post do
      Route.create!(
        source: params[:source],
        start_node: params[:start_node],
        end_node: params[:end_node],
        start_date: params[:start_date],
        end_date: params[:end_date]
      )
    end
  end
end
