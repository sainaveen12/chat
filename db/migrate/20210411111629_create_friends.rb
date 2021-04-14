class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.integer :requestor_id
      t.integer :receiver_id
      t.string :status

      t.timestamps
    end
  end
end
