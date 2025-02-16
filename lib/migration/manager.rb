require "migration/manager/version"

module Migration
  module Manager
    class HomeController < ActionController::Base
      def index
        @text = "Hello, World!"
      end
    end
  end
end