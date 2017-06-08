require 'omniauth-oauth2'
module OmniAuth
  module Strategies
    class Outreach < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "outreach"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {:site => "https://api.outreach.io"}

      #option :provider_ignores_state, true

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['meta']["user"]["email"] }

      info do
        {
          :email => raw_info["meta"]["user"]["email"],
          :api => raw_info["meta"]["api"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/1.0/info').parsed
      end

      #debugging methods
      #def request_phase
      #  #byebug
      #  #puts callback_url
      #  puts "#{client.auth_code.authorize_url({:redirect_uri => callback_url}.merge(options.authorize_params))}"
      #  
      #  redirect client.auth_code.authorize_url({:redirect_uri => callback_url}.merge(options.authorize_params))
      #end
#
      #def callback_phase
      #  puts request.url
      #  super
      #  #byebug
      #end
#
      #def callback_url
      #  full_host + script_name + callback_path + query_string
      #end
#
      #protected
      #def build_access_token
      #  verifier = request.params["code"]
      #  #client.url_prefix="https://api.outreach.io"
      #  byebug
      #  client.auth_code.get_token(verifier, {:redirect_uri => callback_url}.merge(token_params.to_hash(:symbolize_keys => true)), deep_symbolize(options.auth_token_params))
      #end
    end
  end
end