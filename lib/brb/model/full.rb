module Brb
  module Model
    module Full
      extend ActiveSupport::Concern

      included do
        include Brb::Model::Basic
        include Concerns::HasContentBlocks
        include Concerns::HasImage
        include Concerns::HasTags
      end
    end
  end
end