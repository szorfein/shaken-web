class TokenProvider
    def self.issue_token(payload)
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def self.decode(token)
        return JWT.decode(token, Rails.application.secrets.secret_key_base)
    rescue
        nil
    end

    def self.valid(token)
        begin
            JWT.decode(token, Rails.application.secrets.secret_key_base)
        end
    end
end
