ActsAsTaggableOn::Tag.class_eval do
  include Concerns::GenerateSlug
  
  def to_param
    slug
  end
  
end
