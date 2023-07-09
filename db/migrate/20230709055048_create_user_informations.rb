class CreateUserInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_informations do |t|
      t.string :first_name,  null: false, default: ""
      t.string :last_name,   null: false, default: ""
      t.date :date_of_birth, null: false, default: Date.today
      t.string :hometown
      t.text :about_me
      t.references :user, null: false, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
