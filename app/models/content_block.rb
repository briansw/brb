class ContentBlock < ActiveRecord::Base

  belongs_to :parent, polymorphic: true

  @@block_types = Dir.glob("#{Rails.root}/app/models/**/*_block.rb").collect do |block|
    block.gsub(/.*\//, '').gsub('.rb', '').to_sym
  end
  
  @@block_types.each do |block_type|
    has_one block_type, dependent: :destroy
    accepts_nested_attributes_for block_type
  end

  def path_name
    self.block_type.underscore
  end
  
  def as_json(options = {})
    options.reverse_merge! only: [:id], include: @@block_types
    super(options)
  end

  def self.block_types
    @@block_types
  end

  def self.block_list_from_files
    blocks = Dir.glob("#{Rails.root}/app/models/*_block.rb")

    blocks.collect do |block|
      block.gsub!(/.*\//, '').gsub!('.rb', '').to_sym
    end
  end

end
