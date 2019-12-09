# frozen_string_literal: true

module Enumerable

  def my_each
    puts yield(self)
  end

end
