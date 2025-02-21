# script/migrate_data.rb
require "active_record"
require "pg"
require "sqlite3"

# PostgreSQLの設定
pg_config = {
    adapter:  "postgresql",
    host:     "dpg-copkr94f7o1s73e1e2cg-a.oregon-postgres.render.com",
    username: "minorex16",
    password: "a9YXV9hLS7kQXEoyWvr0cnjhQqO2oRgc",
    database: "postgresql_4opt"
}

# SQLiteの設定
sqlite_config = {
    adapter:  "sqlite3",
    database: "storage/production.sqlite3"
}

# PostgreSQLへの接続
ActiveRecord::Base.establish_connection(pg_config)
pg_connection = ActiveRecord::Base.connection

# SQLiteへの接続
ActiveRecord::Base.establish_connection(sqlite_config)
sqlite_connection = ActiveRecord::Base.connection

# ActiveStorageの依存関係を考慮した順序
tables = [
    # まずActiveStorageの基本テーブル
    "active_storage_blobs",           # 最初にblobsを作成
    "active_storage_attachments",     # 次にattachments（blobsに依存）
    "active_storage_variant_records", # 最後にvariant_records（blobsに依存）
    "users",
    "groups",
    "group_users",
    "videos",
    "sns_credentials",
    "notes",
    "responses",
    "practices",
    "daily_practices",
    "daily_practice_items",
    "summaries",
    "ai_practices",
    "timestamps"
] # 移行するテーブル名を列挙

# 最初に全テーブルのデータを削除（逆順で）
puts "Cleaning up existing data..."
tables.reverse.each do |table|
    begin
        puts "Deleting data from #{table}..."
        sqlite_connection.execute("DELETE FROM #{table}")
        sqlite_connection.execute("DELETE FROM sqlite_sequence WHERE name='#{table}'")
    rescue => e
        puts "Error cleaning #{table}: #{e.message}"
    end
end

# テーブルごとにデータを移行（正順で）
puts "Starting data migration..."

tables.each do |table|
    puts "Migrating #{table}..."
    data = pg_connection.select_all("SELECT * FROM #{table}")
    
    data.rows.each do |row|
        attributes = data.columns.zip(row).to_h
        begin
            columns = attributes.keys.join(", ")
            values = attributes.values.map { |v| ActiveRecord::Base.connection.quote(v) }.join(", ")
            sqlite_connection.execute("INSERT INTO #{table} (#{columns}) VALUES (#{values})")
        rescue => e
            puts "Error inserting into #{table}: #{e.message}"
            puts "Attributes: #{attributes.inspect}"
        end
    end

    puts "Table #{table} migrated successfully."
end

puts "Migration completed successfully!"

