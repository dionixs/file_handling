SIGNS = %w[камень ножницы бумага].freeze

CONDITIONS = [
  %w[бумага камень user_win],
  %w[камень ножницы user_win],
  %w[ножницы бумага user_win],
  %w[камень бумага computer_win],
  %w[ножницы камень computer_win],
  %w[бумага ножницы computer_win]
].freeze

def handler_for_user_input(user_input)
  i = 0
  while i < SIGNS.length
    return SIGNS[i] if user_input == SIGNS[i][0]

    i += 1
  end
end

def input
  gets.strip.downcase
end

def winner(comp_sign, user_input)
  return 'Ничья!' if user_input == comp_sign

  i = 0
  while i < CONDITIONS.length
    if CONDITIONS[i][0] == user_input && CONDITIONS[i][1] == comp_sign
      who_win = CONDITIONS[i][-1]
      who_win = who_win == 'user_win' ? 'Вы победили!' : 'Победил компьтер!'
      return who_win
    end
    i += 1
  end
end

try = 1

loop do
  comp_sign = SIGNS.sample

  print 'Нажмите (К(камень) / Н(ножницы) / Б(бумага) для выбора: '
  user_input = input
  user_input = handler_for_user_input(user_input)

  puts "Компьютер выбрал: #{comp_sign}"
  puts "Пользователь выбрал: #{user_input}"

  sleep 1

  if try >= 3
    puts winner(comp_sign, user_input)
    puts 'Вы хотите сыграть еще? (y/n)'
    user_input = input
    user_input == 'y' ? try = 0 : break
  end

  try += 1
end
