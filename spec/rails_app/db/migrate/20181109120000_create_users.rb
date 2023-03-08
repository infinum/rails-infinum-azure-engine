class CreateUsers < ActiveRecord::Migration[5.2]
  def change # rubocop:disable Metrics/MethodLength
    create_table :users do |t|
      t.string :email, null: false, default: ''

      t.string :first_name
      t.string :last_name

      t.string :slack_username
      t.string :time_zone

      t.string :avatar_url

      # Omniauth
      t.string :provider
      t.string :uid

      t.datetime :deactivated_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
