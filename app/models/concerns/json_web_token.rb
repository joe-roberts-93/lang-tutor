require 'jwt'

module JsonWebToken

  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV['JWT_SECRET_KEY'])
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, ENV['JWT_SECRET_KEY'])[0]
    HashWithIndifferentAccess.new decoded
  end
end
