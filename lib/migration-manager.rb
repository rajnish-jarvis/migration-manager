require "migration/manager"
require "migration/manager/version"

module MigrationManager
  class Engine < ::Rails::Engine
    isolate_namespace MigrationManager
  end
end