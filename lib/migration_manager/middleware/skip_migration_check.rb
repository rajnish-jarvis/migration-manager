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
            # Force reload schema to bypass pending migration check
            ActiveRecord::Base.connection.schema_migration.refresh_connection
          rescue ActiveRecord::PendingMigrationError
            # Ignore pending migration error only for migration manager UI
          end
        end

        @app.call(env)
      end
    end
  end
end