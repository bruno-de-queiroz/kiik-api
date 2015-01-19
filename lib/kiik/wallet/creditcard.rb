module Kiik
	class Wallet
		class Creditcard

			def initialize(client)
				@client = client
				@base_uri = '/cards'
			end

			def create(token,options={},&block)
				params = { 
					:card => { 
						:name => options[:name],
						:number => options[:number], 
						:expiration_month => options[:expiration_month], 
						:expiration_year => options[:expiration_year] 
					}
				}

				request(token,:post,@base_uri,params,&block)
			end

			def list(token,&block)
				request(token,:get,@base_uri,{},&block)
			end

			def get(token,id,&block)
				request(token,:get,"#{@base_uri}/#{id}",{},&block)
			end

			def detail(token,id,&block)
				request(token,:get,"#{@base_uri}/#{id}/details",{},&block)
			end

			private
				def request(token,verb,url,params,&block)
					raise RequireAuthorizationToken if token.nil?
					@client.use_token(token, Proc.new { |client| client.request(verb,url,params,&block) })
				end

		end
	end
end