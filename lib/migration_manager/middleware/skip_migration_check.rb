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
          begin
            # Reload migration context to bypass pending migration error
            ActiveRecord::Base.connection.migration_context.migrations
          rescue ActiveRecord::PendingMigrationError
            # Ignore pending migration error only for MigrationManager UI
          end
        end

        @app.call(env)
      end
    end
  end
end