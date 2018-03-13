module Secured
    extend ActiveSupport::Concern

    included do
        before_action :authenticate_request!
    end

    private 

    def authenticate_request!
        auth_token
    rescue JWT::VerificationError, JWT::DecodeError
        render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end

    def auth_token
        TokenProvider.valid(http_token)
    end

    def http_token
        if request.headers['Authorization'].present?
            request.headers['Authorization'].split(' ').last
        end
    end
end
