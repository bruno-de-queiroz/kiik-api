module Kiik
	class Wallet
		class User

			def initialize(client)
				@client = client
				@base_uri = '/users'
				@card = Kiik::Wallet::Creditcard.new(client)
			end

			def create(options={},&block)
				params = { 
					:user => { 
						:email => options[:email], 
						:password => options[:password], 
						:external_id => options[:id] 
					}
				}
				@client.request(:post,@base_uri,request_params(params),&block)
			end

			def set_password(options={},&block)
				params = { 
					:user => { 
						:email => options[:email], 
						:password => options[:password], 
						:new_password => options[:new_password] 
					}
				}
				@client.request(:put,"#{@base_uri}/#{options[:id]}",request_params(params),&block)
			end

			def login(options={},&block)
				params = { 
					:auth => { 
						:external_id => options[:id], 
						:password => options[:password]
					}
				}
				@client.request(:post, '/auth/login', params, &block )
			end

			def regenerate_token(options={},&block)
				params = { 
					:auth => { 
						:external_id => options[:id], 
						:password => options[:password]
					}
				}
				@client.request(:post, '/auth/regenerate_token', params, &block )
			end

			def create_creditcard(options={},&block)
				@card.create(options,&block)
			end

			private
				def request_params(params={})
					params.merge({ :client => { :api_id => @client.id } })
				end
		end
	end
end