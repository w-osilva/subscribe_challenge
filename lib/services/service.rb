# frozen_string_literal: true

class Service
  def self.call(...)
    new(...).call
  end

  def call
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
