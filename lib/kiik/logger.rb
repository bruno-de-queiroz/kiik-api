module Kiik
	class Logger
    def self.info(msg)
      puts "Kiik::INFO: #{msg}"
    end

    def self.warn(msg)
      puts "Kiik::WARN: #{msg}"
    end

    def self.error(msg)
      puts "Kiik::ERROR: #{msg}"
    end

    def self.inspect(msg)
      puts "Kiik::INSPECT:"
      p msg
    end

  end
end