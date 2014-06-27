class CreateContentBlocks < ActiveRecord::Migration
  def change
    create_table :content_blocks do |t|
      t.references :parent, polymorphic: true
      t.string :block_type
      t.integer :position

      t.timestamps
    end
    add_index :content_blocks, [:parent_type, :parent_id, :block_type]
  end
end
