# frozen_string_literal: true

require_relative './concern/constants'
require_relative './concern/my_methods'
require_relative './concern/notes_handling'
require_relative './concern/input_handling'

puts Constants::MENU_COMMANDS

user_input = nil

NotesHandling.run -> { user_input != 'exit' } do
  user_input = InputHandling.handle_input
  begin
    NotesHandling.choice_option(user_input)
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}. Попробуйте еще раз!"
    next
  end
end
