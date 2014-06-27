class CreateImageBlocks < ActiveRecord::Migration
  def change
    create_table :image_blocks do |t|
      t.string :title
      t.text :caption
      t.integer :content_block_id

      t.timestamps
    end
    add_index :image_blocks, [:content_block_id]
  end
end
