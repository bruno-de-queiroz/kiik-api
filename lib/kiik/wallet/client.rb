module Kiik
	class Wallet
		class Client

   		ALLOWED_TYPES = {
   			:client => [ :create, :detail ],
   			:user => [ :create ],
   			:creditcard => [ :create, :detail ],
   			:transaction => [ :create ]
   		}

			attr_reader :name, :id, :secret, :access_token, :email

			def initialize(wallet,options)
				@id = options[:api_id]
				@name = options[:name]
				@email = options[:email]
				@secret = options[:api_secret]
				@access_token = options[:access_token]
				@wallet = wallet
				@base_uri = '/clients/#{id}'
			end

			def token
				@wallet.token
			end

			def client
				@wallet.client
			end

	    def use_token(new_token,&block)
	      @wallet.client.token = new_token
	      block.call(self)
	      @wallet.client.token =  @wallet.token
	    end

			def detail(type,options={},&block)
				allow(type,:detail)

				case type
				when :client
					request(:get, base_uri,{}, &block)
				when :creditcard
					token = options.delete(:token)
					card.detail(token,options,&block)
				end

			end

			def list(type,options={},&block)
				allow(type,:list)

				case type
				when :creditcard
					token = options.delete(:token)
					card.list(token,&block)
				end

			end

			def set_secret(secret,&block)
				request(:put, base_uri, { :client => { :api_secret => secret } },&block)
			end

			def create(type, options={},&block)
				allow(type,:create)

				token = options.delete(:token)
				case type
				when :user
					user.create(options,&block)
				when :creditcard
					card.create(token,options,&block)
				when :transaction
					transaction.create(token,options.delete(:credit_card),options,&block)
				end
			end

			def user
				@user ||= Kiik::Wallet::User.new(self)
			end

			def card
				@card ||= Kiik::Wallet::Creditcard.new(self)
			end

			def transaction
				@transaction ||= Kiik::Wallet::Transaction.new(self)
			end

			def request(verb, uri, params = {}, &block)
				response = @wallet.client.request(verb, "/#{@wallet.version}#{uri}", request_params(params))

				if block_given?
					yield(response.body)
				else
					response.body
				end
			end

			private
				def allow(type,method)
					raise TypeNotSupported.new("The #{type} is not supported by this api") if !ALLOWED_TYPES.include?(type)
					raise MethodNotAllowedForType.new("This type: #{type} don't allow this method.") if !ALLOWED_TYPES[type].include?(method)
				end

				def request_params(params={})
					p = { 
						:params => {},
						:body => params.to_json,
						:headers => {
							'Accept' => 'application/json',
							'Content-type' => 'application/json'
						}
					}
					p
				end

		end
	end
end