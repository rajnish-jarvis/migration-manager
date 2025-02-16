module MigrationManager
  module Middleware
    class SkipMigrationCheck
      def initialize(app)
        @app = app
      end

      def call(env)
        request = Rack::Request.new(env)

        # Skip migration check only for MigrationManager routes
        if request.path.start_with?("/migration_manager")
          ActiveRecord::Base.connection.migration_context.clear_cache!
        end

        @app.call(env)
      rescue ActiveRecord::PendingMigrationError
        @app.call(env) # Ignore the error for migration routes
      end
    end
  end
end