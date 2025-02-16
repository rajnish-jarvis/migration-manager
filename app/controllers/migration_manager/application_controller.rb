module MigrationManager
  class ApplicationController < ActionController::Base
    before_action :authenticate_user

    private

    def authenticate_user
      authenticate_or_request_with_http_basic do |user, password|
        user == ENV['MIGRATION_MANAGER_USER'] && password == ENV['MIGRATION_MANAGER_PASSWORD']
      end
    end
  end
end