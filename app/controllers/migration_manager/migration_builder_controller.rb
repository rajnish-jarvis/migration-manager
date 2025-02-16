module MigrationManager
  class MigrationBuilderController < MigrationManager::ApplicationController
    def new
      @tables = ActiveRecord::Base.connection.tables.reject { |t| t == 'schema_migrations' }
    end

    def create
      operation = params[:operation] # "create_table" or "alter_table"
      table_name = params[:table_name].presence
      columns = params[:columns] || []

      return redirect_to request.referer, alert: "Table name is required" if table_name.blank?

      migration_name = generate_migration_name(operation, table_name, columns)
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      formatted_file_name = migration_name.underscore

      file_name = "#{timestamp}_#{formatted_file_name}.rb"
      file_path = Rails.root.join("db/migrate/#{file_name}")

      migration_content = generate_migration_content(migration_name, operation, table_name, columns)

      File.open(file_path, "w") { |file| file.write(migration_content) }

      redirect_to "#{request.base_url}/migration_manager/home", notice: "Migration #{file_name} created successfully!"
    end

    private

    def generate_migration_name(operation, table, columns)
      if operation == "create_table"
        "Create#{table.singularize.camelize}"
      elsif operation == "alter_table" && columns.any?
        column_names = columns.map { |col| col[:name].camelize }.join("And")
        "Add#{column_names}To#{table.camelize}"
      else
        "Update#{table.camelize}"
      end
    end

    def generate_migration_content(name, operation, table, columns)
      <<~RUBY
    class #{name} < ActiveRecord::Migration[7.0]
      def change
        #{operation == "create_table" ? create_table_code(table, columns) : alter_table_code(table, columns)}
      end
    end
  RUBY
    end

    def create_table_code(table, columns)
      col_definitions = columns.map do |col|
        "      t.#{col[:type]} :#{col[:name]}#{default_value(col[:default])}"
      end.join("\n")

      <<~RUBY
        create_table :#{table} do |t|
        #{col_definitions}
          t.timestamps
        end
      RUBY
    end

    def alter_table_code(table, columns)
      columns.map do |col|
        "    add_column :#{table}, :#{col[:name]}, :#{col[:type]}#{default_value(col[:default])}"
      end.join("\n")
    end

    def default_value(value)
      value.present? ? ", default: #{value.inspect}" : ""
    end
  end
end