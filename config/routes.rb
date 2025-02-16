MigrationManager::Engine.routes.draw do
  get 'home', to: 'home#index'
  post 'run_migration', to: 'home#run_migration'

  # Migration Builder UI
  get 'new_migration', to: 'migration_builder#new'
  post 'create_migration', to: 'migration_builder#create'
end