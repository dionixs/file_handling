# frozen_string_literal: true

require_relative './my_methods'

SIGNS = %w[камень ножницы бумага].freeze

CONDITIONS = [
  %w[бумага камень user_win],
  %w[камень ножницы user_win],
  %w[ножницы бумага user_win],
  %w[камень бумага computer_win],
  %w[ножницы камень computer_win],
  %w[бумага ножницы computer_win]
].freeze

COMMAND_LIST = [
  "1. камень\t2. ножницы\t3. бумага",
  'Введите цифру варианта: '
].freeze

def handler_for_user_input(user_input)
  index = user_input.to_i

  raise 'Ошибка при выборе варианта!' if index < 1 || index > SIGNS.length

  SIGNS[index - 1]
end

def input
  gets.strip.downcase
end

def play_again?
  sleep 1
  puts 'Вы хотите сыграть еще? (y/n)'
  user_input = input
  user_input == 'y'
end

def winner(comp_sign, user_input)
  sleep 1

  return 'Ничья!' if user_input == comp_sign

  i = 0
  while i < CONDITIONS.length
    next unless CONDITIONS[i][0] == user_input && CONDITIONS[i][1] == comp_sign

    who_win = CONDITIONS[i][-1]
    who_win = who_win == 'user_win' ? 'Вы победили!' : 'Победил компьтер!'
    return who_win
  end
end

def display_select_signs(user_input, comp_sign, round)
  sleep 1
  puts "Пользователь выбрал: #{user_input}"
  puts "Компьютер выбрал: #{comp_sign}"
end


round = 0

begin
  loop do
    comp_sign = SIGNS.sample

    puts COMMAND_LIST

    user_input = handler_for_user_input(input)
    display_select_signs(user_input, comp_sign, round)

    round += 1
    if round == 3
      puts winner(comp_sign, user_input)
      play_again? ? round = 0 : break
    end
  rescue StandardError => e
    round -= 1
    puts "Возникла ошибка: #{e.message}."
  end
rescue Interrupt
  puts
end
