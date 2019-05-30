module V1
  module Sites
    class UpsertSite
      attr_accessor :args, :site
      
      def initialize(args)
        @args = args
      end

      def exec
        validate_args
        _upsert
      rescue Exception => e
        Rails.logger.error("V1::Sites::UpsertSite | Error: #{e.message} | Backtrace: \n#{e.backtrace.join("\n")}")
        return nil, e.message
      end

      private
      
      def _upsert
        find_or_create
        @site.update_attributes(args)
        @site
      end
      
      def find_or_create
        @site = Site.find_or_create_by(site_key: args[:site_key])
      end

      def validate_args
        check_if_args_contain_site_key
        check_if_args_contain_regions_key
        check_if_args_contrain_valid_regions_details
      end

      def check_if_args_contain_site_key
        raise MissingAttributesError, :site_key unless args[:site_key]
      end

      def check_if_args_contain_regions_key
        raise MissingAttributesError, :regions unless args[:regions]
      end

      def check_if_args_contrain_valid_regions_details
        regions = Settings.regions.keys
        flag = args[:regions].keys.any?{|a| regions.include?(a.to_sym)}
        raise MissingAttributesError, "valid_regions should be #{regions}" unless flag
      end
    end
  end
end