class CreateTextBlocks < ActiveRecord::Migration
  def change
    create_table :text_blocks do |t|
      t.string :title
      t.integer :content_block_id
      t.text :body

      t.timestamps
    end
    add_index :text_blocks, [:content_block_id]
  end
end
