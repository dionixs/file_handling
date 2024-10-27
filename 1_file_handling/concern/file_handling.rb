# frozen_string_literal: true

require_relative './constants'
require_relative './input_handling'
require_relative './my_methods'

module FileHandling
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
      read_file
    elsif user_input.to_i == 2
      write_file
    elsif user_input.to_i == 3
      read_file(true)
    elsif user_input.to_i == 4
      copy_file
    elsif user_input.to_i == 5
      write_file_append
    elsif user_input.to_i == 6
      remove_file
    elsif user_input.to_i == 7
      reverse_file
    elsif user_input.to_i == 8
      count
    elsif user_input == 'help'
      puts Constants::MENU_COMMANDS
    end
  end

  private

  def self.get_file_by_name(file_name)
    Dir.entries(current_directory).my_each do |file|
      return file if file.split('.')[0] == file_name
    end
  end

  def self.current_directory
    Dir.pwd
  end

  def self.incorrect_input?(user_input)
    return false if user_input == 'exit'

    user_input.to_i == 0 && user_input != 'help'
  end

  def self.file_name(str = 'Введите имя файла:')
    puts str
    InputHandling.handle_input
  end

  def self.input_text
    puts 'Введите текст:'
    gets
  end

  def self.read_file(str_number = nil)
    path = get_file_by_name(file_name)

    raise 'Файл не найден!' unless File.exist?(path)

    File.open("./#{path}", 'r:UTF-8') do |file|
      puts "Содержимое файла #{path}:"
      file.readlines.my_each_with_index do |line, index|
        puts !str_number ? line : "#{index + 1} #{line}"
      end
    end
  end

  def self.write_file(mode = 'w:UTF-8', text = nil)
    # TODO: Придумать  как сделать
    # что бы можно было писать в файл более одной строки
    # например сделать так что бы по нажатию на ctrl + q
    # запись в файл прекращалась
    text = text.nil? ? input_text : text
    File.open("./#{file_name}.txt", mode) do |file|
      file.puts text
    end
    puts 'Запись в файл завершена!'
  end

  def self.write_file_append
    write_file('a:UTF-8')
  end

  def self.copy_file
    original_file = file_name('Введите исходное имя файла:')
    copy_file = file_name('Введите целевое имя файла:')
    path = get_file_by_name(original_file)

    raise 'Файл не найден!' unless File.exist?(path)

    original_file = File.open("./#{path}", 'r:UTF-8') if File.exist?(path)

    # warning: File::new() does not take block; use File::open() instead
    # поэтому надо использовать open
    File.open("./#{copy_file}.txt", 'w:UTF-8') do |copy_file|
      original_file.readlines.my_each do |line|
        copy_file.puts(line)
      end
    end
    puts 'Копирование файла завершено!'
  end

  def self.remove_file
    file = file_name('Введите имя файла который хотите удалить:')
    File.delete("#{file}.txt")
    puts 'Файл успешно удален!'
  end

  def self.count
    path = get_file_by_name(file_name)

    raise 'Файл не найден!' unless File.exist?(path)

    readlines = nil

    File.open("./#{path}", 'r:UTF-8') do |file|
      readlines = file.readlines
    end
    puts "Количество строк: #{count_str(readlines)}, символов: #{count_char(readlines)} в файле #{path}"
  end

  def self.count_str(arr)
    arr.my_size
  end

  # тут учитываються управ. символы
  # так же узнал что в linux есть команда wc -m file_name.txt
  # она тоже их учитывает
  def self.count_char(arr)
    size = 0
    arr.my_each do |line|
      size += line.length
    end
    size
  end

  def self.reverse_file
    file_original = file_name('Введите имя файла который хотите реверснуть:')
    readlines = nil
    File.open("./#{file_original}.txt", 'r:UTF-8') do |file|
      readlines = file.readlines
    end
    File.open("./#{file_original}_reverse.txt", 'w:UTF-8') do |file|
      readlines.my_reverse.my_each do |line|
        file.puts line
      end
    end
    puts 'Файл успешно реверснут!'
  end
end
