# frozen_string_literal: true
class API < Grape::API
  version 'v1', using: :header, vendor: 'Matrix'
  format :json
  prefix :api

  helpers do
    def valid_passphrase
      return false unless params[:passphrase]
      passphrase = params[:passphrase]
      Rails.application.passphrase == passphrase
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless valid_passphrase
    end
  end
end
