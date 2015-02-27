module Kiik

  class Client

    attr_reader :site
    attr_accessor :token, :options

    def initialize(token, options={}, &block)
      opts = options.dup
      @token = token
      @site = opts.delete(:site)
      ssl = opts.delete(:ssl)
      @options = {:connection_opts  => {},
                  :connection_build => block,
                  :max_redirects    => 5,
                  :raise_errors     => true}.merge(opts)
      @options[:connection_opts][:ssl] = ssl if ssl
    end

    def site=(value)
      @connection = nil
      @site = value
    end

    # The Faraday connection object
    def connection
      @connection ||= begin
        conn = Faraday.new(site, options[:connection_opts])
        conn.build do |b|
          options[:connection_build].call(b)
        end if options[:connection_build]
        conn
      end
    end

    def authorization_header(params = {})
      params.merge({ 'Authorization' => "Token token=#{token}" })
    end

    def request(verb, url, opts = {})
      connection.response :logger, ::Logger.new($stdout) if ENV['OAUTH_DEBUG'] == 'true'

      url = connection.build_url(url, opts[:params]).to_s

      Kiik::Logger.info(url)

      response = connection.run_request(verb, url, opts[:body], authorization_header(opts[:headers])) do |req|
        Kiik::Logger.inspect(req)
        yield(req) if block_given?
      end

      Kiik::Logger.inspect(response)

      response = Response.new(response, :parse => opts[:parse])

      case response.status
      when 301, 302, 303, 307
        opts[:redirect_count] ||= 0
        opts[:redirect_count] += 1
        return response if opts[:redirect_count] > options[:max_redirects]
        if response.status == 303
          verb = :get
          opts.delete(:body)
        end
        request(verb, response.headers['location'], opts)
      when 200..299, 300..399
        # on non-redirecting 3xx statuses, just return the response
        response
      when 400..599
        error = Error.new(response)
        fail(error) if opts.fetch(:raise_errors, options[:raise_errors])
        response.error = error
        response
      else
        error = Error.new(response)
        fail(error, "Unhandled status code value of #{response.status}")
      end
    end


  end

end