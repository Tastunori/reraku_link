class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :employee_num
      t.string :password
      t.string :image_name
      t.string :store_name
      t.string :position

      t.timestamps
    end
  end
end
