MigrationManager::Engine.routes.draw do
  get "hello", to: "migration/manager/hello#index"
end