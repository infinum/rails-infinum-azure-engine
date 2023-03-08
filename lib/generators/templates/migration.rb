class CreateUsers < ActiveRecord::Migration<%= migration_version %>
  def change # rubocop:disable Metrics/MethodLength
    create_table :users do |t|
      t.string :email, null: false, default: ''

      t.string :name

      # Omniauth
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
