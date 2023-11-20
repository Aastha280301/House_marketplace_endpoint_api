# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  
  include RackSessionsFix
  respond_to :json

 private
  def respond_with(current_user, _opts = {})
    render json: {
      status: { 
        code: 200, message: 'Logged in successfully.',
        data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
      }
    }, status: :ok
  end
  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first || '9okDHL8a09X9TkEjAO6frTNpgxPvA6GQZmKunOnhZJlQVnWOyvDM2Z0WkTCtNpp7I8/CROWTqK/p719PMo04NQFixJ9M9KCKVnXPPNA4j1n/fC8usghXB/wEnNK+1QNWxZts5xRszvihfZrxtKH3cVvl7+5fQ5wKX4+orFo+bYaNbbEE4TjGWeB/CfeDpDEXhXCEZyGP1HH4aGwSdRFLYgJmB3Edom6/NQHjcip3DE2m8vkMM/abB1mLJ6RQ6NL8oQoywvzKNg6Wl7PggLmnY033G+MiN5GViWKfxK+cJRS+GNIOFRenrzIifaNlspSwjwAoB5SzolafALVs/Z+3/c+yNvUfNa7hB/i0D9OLwsqnzrEZIrNkVWS1MavCKm7dXFbFTpsLuufMri33t7GRBjntbMBspURHAIzPSw==--1tMx/yhhspnE6LEf--0KeD9R8nkSr1FNPEx36AAg=='
      current_user = User.find(jwt_payload['sub'])
    end
    
    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end