module MigrationManager
  class HelloController < MigrationManager::ApplicationController
    def index
      @text = "Hello, World!"
      render plain: @text
    end
  end
end