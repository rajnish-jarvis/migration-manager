require "rails"
require "rails/engine"

module MigrationManager
  class Engine < ::Rails::Engine
    isolate_namespace MigrationManager
  end
end