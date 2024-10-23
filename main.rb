# frozen_string_literal: true

require_relative './concern/constants'
require_relative './concern/my_methods'
require_relative './concern/file_handling'
require_relative './concern/input_handling'

puts Constants::MENU_COMMANDS

user_input = nil

FileHandling.run -> { user_input != 'exit' } do
  user_input = InputHandling.handle_input
  begin
    FileHandling.choice_option(user_input)
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}. Попробуйте еще раз!"
    next
  end
end






# puts Constants::MENU_COMMANDS
#
# loop do
#   print '> '
#   user_input = gets.strip.downcase
#
#   if user_input.to_i == 1
#     puts 'Введите имя файла: '
#     file_name = get_input
#     path = get_file_by_name(file_name)
#     file = File.open("./#{path}", 'r:UTF-8') if File.exist?(path)
#     puts file.readlines
#     file.close
#   elsif user_input.to_i == 2
#     # тут надо обдумать как сделать
#     # что бы можно было писать в файл более одной строки
#     puts 'Введите текст:'
#     text = gets
#     puts 'Введите имя файла: '
#     file_name = get_input
#     file = File.new("./#{file_name}.txt", 'w:UTF-8')
#     file.puts text
#     file.close
#   elsif user_input.to_i == 3
#     puts 'Введите имя файла: '
#     file_name = get_input
#     path = get_file_by_name(file_name)
#     file = File.open("./#{path}", 'r:UTF-8') if File.exist?(path)
#     file.readlines.each_with_index do |line, index|
#       puts "#{index + 1} #{line}"
#     end
#     file.close
#   elsif user_input.to_i == 4
#     puts 'Введите исходное имя файла:'
#     original_file = get_input
#     puts 'Введите целевое имя файла:'
#     copy_file = get_input
#     copy_file = File.new("./#{copy_file}.txt", 'w:UTF-8')
#     path = get_file_by_name(original_file)
#     original_file = File.open("./#{path}", 'r:UTF-8') if File.exist?(path)
#     original_file.readlines.each do |line|
#       copy_file.puts(line)
#     end
#     copy_file.close
#     original_file.close
#   elsif user_input.to_i == 5
#     puts 'Введите текст:'
#     text = gets
#     puts 'Введите имя файла: '
#     file_name = get_input
#     file = File.new("./#{file_name}.txt", 'a:UTF-8')
#     file.puts text
#     file.close
#   elsif user_input.to_i == 6
#     puts 'Введите имя файла который хотите удалить:'
#     file_name = get_input
#     File.delete("#{file_name}.txt")
#   elsif user_input == 'help'
#     puts Constants::MENU_COMMANDS
#   elsif user_input == 'exit'
#     break
#   end
# end
