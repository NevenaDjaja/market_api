class ApiConstraints
	def initialize(options)
		@version = options[:version]
		@default = options[:default]
		puts @default
	end

	def matches?(req)
		if @default
			@default
		else
		 req.headers['Accept'].include?("application/vnd.marketplace.v#{@version}")
		end
	end

end