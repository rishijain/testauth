module V1
  module Users
    class UpsertUser
      attr_accessor :args, :user

      def initialize(args)
        @args = args
      end

      def exec
        _upsert
      rescue Exception => e
        Rails.logger.error("V1::Users::UpsertUser | Error: #{e.message} | Backtrace: \n#{e.backtrace.join("\n")}")
        return nil, e.message  
      end

      private

      def _upsert
        find_or_create
        regions = Hash(@user.regions)
        regions.merge!(Hash(args[:regions]))
        args.merge!(regions: regions)
        @user.update_attributes!(args)
        @user
      end

      def find_or_create
        @user = User.find_or_create_by(email: args[:email])
      end
    end
  end
end