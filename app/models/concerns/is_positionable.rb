module Concerns::IsPositionable
  extend ActiveSupport::Concern

  included do
    scope :positioned, -> { order(:position) }
    after_save :set_positions
  end


  def set_positions
    records = self.class.all.active.positioned.to_a.reject!{ |record| record == self }
    index = self.position - 1 < 0 ? 0 : self.position - 1
    records.insert(index, self).compact!

    records.each_with_index do |record, x|
      position = x + 1
      record.update_columns(position: position)
    end
  end

end
