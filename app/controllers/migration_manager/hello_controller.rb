module MigrationManager
  class HelloController < MigrationManager::ApplicationController
    def index
      @text = "Hello, World!"
    end
  end
end