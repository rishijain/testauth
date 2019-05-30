module V1
  module Sites
    class UpsertSite
      attr_accessor :args, :site
      
      def initialize(args)
        @args = args
      end

      def exec
        _upsert
      rescue Exception => e
        Rails.logger.error("V1::Sites::UpsertSite | Error: #{e.message} | Backtrace: \n#{e.backtrace.join("\n")}")
        return nil, e.message
      end

      private
      
      def _upsert
        find_or_create
        @site.update_attributes!(args)
        @site
      end
      
      def find_or_create
        @site = Site.find_or_create_by(site_key: args[:site_key])
      end

    end
  end
end