module MigrationManager
  class HelloController < MigrationManager::ApplicationController
    def index
      migrations_paths = ActiveRecord::Migrator.migrations_paths
      migration_context = ActiveRecord::MigrationContext.new(migrations_paths, ActiveRecord::Base.connection.schema_migration)

      @all_migrations = migration_context.migrations
      @applied_migrations = migration_context.get_all_versions.map(&:to_s)

      # Mark migration as pending if it's not applied
      @migration_statuses = @all_migrations.map do |migration|
        {
          version: migration.version,
          name: migration.name,
          status: @applied_migrations.include?(migration.version.to_s) ? "✅ Applied" : "⏳ Pending"
        }
      end
    end
  end
end