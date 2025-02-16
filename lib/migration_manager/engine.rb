require "rails"
require "rails/engine"

module MigrationManager
  class Engine < ::Rails::Engine
    isolate_namespace MigrationManager
    config.after_initialize do
      ActiveSupport.on_load(:after_initialize) do
        Rails.application.config.middleware.delete ActiveRecord::Migration::CheckPending
      end
    end
  end
end