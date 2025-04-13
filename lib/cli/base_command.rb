# frozen_string_literal: true

class BaseCommand
  def self.execute(...)
    new(...).execute
  end

  def execute
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def execution
    yield self if block_given?
    self
  end
end
