module Concerns::Positionable
  extend ActiveSupport::Concern

  included do
    scope :positioned, -> { order(:position) }
    after_save :set_positions
  end


  def set_positions
    if self.respond_to?('position')
      records = self.class.all.active.positioned.to_a.reject!{ |record| record == self }
      self.position ||= last_position(records)
      index = self.position - 1 < 0 ? 0 : self.position - 1
      records.insert(index, self).compact!

      records.each_with_index do |record, x|
        position = x + 1
        record.update_columns(position: position)
      end
    end
  end

  def last_position(records)
    if records.present?
      records.last.position + 1
    else
      1
    end
  end

end
