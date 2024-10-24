# frozen_string_literal: true

require_relative './constants'
require_relative './input_handling'
require_relative './my_methods'
require 'date'

module NotesHandling
  def self.run(condition)
    loop do
      break unless condition.call

      yield
    end
    # перехватываем прерывание и делаем красивый выход
    # из программы
    # по нажатию на ctrl + с
  rescue Interrupt
    puts
  end

  def self.choice_option(user_input)
    raise 'Выбрана не верная опция!' if incorrect_input?(user_input)

    if user_input.to_i == 1
      create_note
    elsif user_input.to_i == 2
      remove_note!
    elsif user_input.to_i == 3
      show_note
    elsif user_input.to_i == 4
      edit_note
    elsif user_input == 'help'
      puts Constants::MENU_COMMANDS
    end
  end

  private

  def self.create_note
    text = text.nil? ? input_text : text
    if File.exist?("#{current_date}.txt")
      create_file(text, mode = 'a:UTF-8')
    else
      create_file(text)
    end
    puts 'Запись в файл завершена!'
  end

  def self.create_file(text, mode = 'w:UTF-8', file = nil)
    file_name = if file.nil?
                  current_date
                else
                  file
                end
    File.open("./#{file_name}.txt", mode) do |f|
      f.puts text
    end
  end

  def self.remove_note!
    file = file_name('Введите имя заметки которую хотите удалить:')
    File.delete("#{file}.txt")
    puts 'Заметка успешна удален!'
  end

  def self.show_note
    file = file_name('Введите имя заметки которую хотите посмотреть:')
    read_file(file)
  end

  def self.read_file(filename, mode = 'r:UTF-8')
    raise 'Файл не найден!' unless File.exist?("#{filename}.txt")

    File.open("./#{current_date}.txt", mode) do |file|
      puts "Содержимое файла #{current_date}.txt :"
      file.readlines.my_each_with_index do |line|
        puts line
      end
    end
  end

  def self.edit_note
    file = file_name('Введите имя заметки которую хотите отредактировать:')
    text = input_text
    edit_file(text, file, 'a:UTF-8')
    puts 'Текст добавлен в файл!'
  end

  def self.incorrect_input?(user_input)
    return false if user_input == 'exit'

    user_input.to_i == 0 && user_input != 'help'
  end

  def self.input_text
    puts 'Введите текст:'
    gets
  end

  def self.file_name(str = 'Введите имя файла:')
    puts str
    InputHandling.handle_input
  end

  def self.current_date
    Date.today.strftime('%d_%m_%Y').to_s
  end

  def self.edit_file(text, file, mode = 'a:UTF-8')
    create_file(text, mode, file)
  end
end
