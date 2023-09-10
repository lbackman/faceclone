class ChangeUserInformationsDateOfBirthNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :user_informations, :date_of_birth, true
  end
end
