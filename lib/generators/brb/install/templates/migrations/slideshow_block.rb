class CreateSlideshowBlocks < ActiveRecord::Migration
  def change
    create_table :slideshow_blocks do |t|
      t.integer :content_block_id

      t.timestamps
    end
  end
end
