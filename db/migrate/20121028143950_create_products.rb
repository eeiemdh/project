class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_url
      t.integer :user_id

      t.timestamps
    end
  end
end
