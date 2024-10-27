# frozen_string_literal: true

module InputHandling

  def self.handle_input
    print '> '
    gets&.strip&.downcase
  end
end
