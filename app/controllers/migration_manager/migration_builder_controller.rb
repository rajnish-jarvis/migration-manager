module MigrationManager
  class MigrationBuilderController < MigrationManager::ApplicationController
    def new
      @tables = ActiveRecord::Base.connection.tables
    end

    def create
      migration_name = params[:migration_name].presence || "custom_migration"
      operation = params[:operation] # "create_table" or "alter_table"
      table_name = params[:table_name].presence
      columns = params[:columns] || []

      file_name = "#{Time.now.strftime('%Y%m%d%H%M%S')}_#{migration_name.underscore}.rb"
      file_path = Rails.root.join("db/migrate/#{file_name}")

      migration_content = generate_migration_content(migration_name, operation, table_name, columns)

      File.open(file_path, "w") { |file| file.write(migration_content) }

      redirect_to "#{request.base_url}/migration_manager/home", notice: "Migration #{file_name} created successfully!"
    end

    private

    def generate_migration_content(name, operation, table, columns)
      <<~RUBY
        class #{name.camelize} < ActiveRecord::Migration[7.0]
          def change
            #{operation == "Create Table" ? create_table_code(table, columns) : alter_table_code(table, columns)}
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