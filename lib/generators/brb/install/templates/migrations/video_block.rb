class CreateVideoBlocks < ActiveRecord::Migration
  def change
    create_table :video_blocks do |t|
      t.text :url
      t.text :video_id
      t.string :title
      t.text :caption
      t.integer :content_block_id

      t.timestamps
    end
  end
end
