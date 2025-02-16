module MigrationManager
  class HomeController < MigrationManager::ApplicationController
    def index
      # Get all migrations and their statuses
      @migrations = ActiveRecord::Base.connection.execute(
        "SELECT version FROM schema_migrations"
      ).map { |row| row["version"] }.sort.reverse # Sort DESC

      @all_migrations = ActiveRecord::Migrator.migrations_paths.flat_map do |path|
        ActiveRecord::MigrationContext.new(path).migrations
      end.sort_by(&:version).reverse

      @pending_migrations = @all_migrations.reject { |m| @migrations.include?(m.version.to_s) }

      @success_message = params[:success] if params[:success].present?
    end

    def run_migration
      version = params[:version]

      if version.present?
        ActiveRecord::Migrator.run(:up, ActiveRecord::Migrator.migrations_paths, version.to_i)
        redirect_to migration_manager_home_path(success: "Migration #{version} successfully run.")
      else
        redirect_to migration_manager_home_path, alert: "Invalid migration version."
      end
    end
  end
end