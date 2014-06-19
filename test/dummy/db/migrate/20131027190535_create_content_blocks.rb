class CreateContentBlocks < ActiveRecord::Migration
  def change
    create_table :content_blocks do |t|
      t.integer  "parent_id"
      t.string   "parent_type"
      t.string   "block_type"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"

      t.timestamps
    end
    
    add_index :content_blocks, [:parent_type, :parent_id, :block_type], name: 'index_content_blocks_on_many_fields'
  end
end
