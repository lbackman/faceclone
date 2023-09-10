class RemoveDefaultValueUserInformationsDateOfBirth < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        change_column_default(:user_informations, :date_of_birth, nil)
      end

      dir.down do
        change_column_default(:user_informations, :date_of_birth, Date.today)
      end    
    end
  end
end
