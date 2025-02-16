require "rails"
require "rails/engine"

module MigrationManager
  class Engine < ::Rails::Engine
    isolate_namespace MigrationManager
    initializer "migration_manager.skip_migration_check" do |app|
      app.config.middleware.insert_before(
        ActiveRecord::Migration::CheckPending,
        MigrationManager::Middleware::SkipMigrationCheck
      )
    end
  end
end