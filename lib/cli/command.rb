# frozen_string_literal: true

class Command
  def self.execute(...)
    new(...).execute
  end

  def execute
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
