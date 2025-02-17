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
    database: "db/production.sqlite3"
}

# PostgreSQLへの接続
ActiveRecord::Base.establish_connection(pg_config)
pg_connection = ActiveRecord::Base.connection

# SQLiteへの接続
ActiveRecord::Base.establish_connection(sqlite_config)
sqlite_connection = ActiveRecord::Base.connection

# テーブルごとにデータを移行
tables = ["users", "groups", "group_users", "videos", "sns_credentials", "notes", "responses", "practices", "daily_practices", "daily_practice_items", "summaries", "ai_practices", "timestamps"] # 移行するテーブル名を列挙
tables.each do |table|
    puts "Migrating #{table}..."
    data = pg_connection.select_all("SELECT * FROM #{table}")
    data.rows.each do |row|
        attributes = data.columns.zip(row).to_h
        begin
            sqlite_conn.insert_fixture(attributes, table)
        rescue => e
            puts "Error inserting into #{table}: #{e.message}"
        end
    end

    puts "Table #{table} migrated successfully."
end

puts "Migration completed successfully!"
