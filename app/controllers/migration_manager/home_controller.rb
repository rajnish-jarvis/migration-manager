module MigrationManager
  class HomeController < MigrationManager::ApplicationController
    def index
      @migrations = fetch_applied_migrations
      @all_migrations = fetch_all_migrations
      @pending_migrations = @all_migrations.reject { |m| @migrations.include?(m.version.to_s) }

      @success_message = params[:success] if params[:success].present?
    end

    def run_migration
      version = params[:version]

      if version.present?
        ActiveRecord::Migrator.run(:up, ActiveRecord::Migrator.migrations_paths, version.to_i)
        redirect_to "#{request.base_url}/migration_manager/home", notice: "Migration #{version} successfully run!"
      else
        redirect_to "#{request.base_url}/migration_manager/home", alert: "Invalid migration version."
      end
    end

    private

    def fetch_applied_migrations
      ActiveRecord::Base.connection.select_values("SELECT version FROM schema_migrations").map(&:to_s)
    rescue ActiveRecord::StatementInvalid, ActiveRecord::NoDatabaseError
      []
    end

    def fetch_all_migrations
      ActiveRecord::Migrator.migrations_paths.flat_map do |path|
        ActiveRecord::MigrationContext.new(path).migrations
      end.sort_by(&:version).reverse
    rescue ActiveRecord::StatementInvalid, ActiveRecord::NoDatabaseError
      []
    end
  end
end