class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string   "attachment"
      t.integer  "parent_id"
      t.string   "parent_type"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "relationship_name"
      t.text     "caption"
      t.integer  "position"
      t.integer  "width"
      t.integer  "height"
      t.string   "content_type"

      t.timestamps
    end
    
    add_index :images, [:parent_id, :parent_type]
  end
end
