class PostSub < ActiveRecord::Migration
  def change
    create_table :post_sub do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false

      t.timestamps
    end

    remove_column :posts, :sub_id

  end
end
