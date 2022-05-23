class Mastermind
  COLORS = ["red", "orange", "yellow", "green", "blue", "purple"]
  @@arr = []
  @@turn = 0
  @@first = ''
  @@second = ''
  @@third = ''
  @@fourth = ''
  @@guess_arr = []
  @@game_over = false
  attr_accessor :first, :second, :third, :fourth

  def initialize
    i = 0
    while i < 4
      @@arr.push(COLORS.sample)
      i += 1
    end
    puts @@arr
    welcome
    play
  end

  def welcome #introduction to rules
    puts 'Welcome to Mastermind!'
    puts 'The computer has chosen four random colors out of the following: '
    puts 'Red, orange, yellow, green, blue, purple'
    puts 'Duplicate colors are allowed.'
    puts 'You will guess the colors.'
    puts 'You have 12 guesses to get the correct order and colors.'
    puts 'After each guess, the computer will give you an output.'
    puts "A 'c' means that the color and placement are correct."
    puts "A 'p' means the color is correct but the placement is incorrect."
    puts "An 'x' means that neither color or placment is correct."
  end

  def play
    while @@game_over == false && @@turn < 12
      guess_order
      return_information
    end
    if @@turn >= 12
      puts "You lose!"
    end
  end

  def guess_order
    i = 1
    while i < 5
      puts "Please guess the #{i} color: "
      guess = gets.chomp.downcase
      until COLORS.include?(guess) == true
        puts 'Please guess a valid color.'
        guess = gets.chomp.downcase
      end
      if i == 1
        @@first = guess
      elsif i == 2
        @@second = guess
      elsif i == 3
        @@third = guess
      else
        @@fourth = guess
      end
      i += 1
    end
    puts "Your guess was #{@@first}, #{@@second}, #{@@third}, #{@@fourth}."
    @@turn += 1
  end

  def return_information
    if @@first == @@arr[0]
      @@guess_arr[0] = 'c'
    elsif @@arr.include?(@@first) == true
      @@guess_arr[0] = 'p'
    else
      @@guess_arr[0] = 'x'
    end
    if @@second == @@arr[1]
        @@guess_arr[1] = 'c'
      elsif @@arr.include?(@@second) == true
        @@guess_arr[1] = 'p'
      else
        @@guess_arr[1] = 'x'
    end
    if @@third == @@arr[2]
        @@guess_arr[2] = 'c'
      elsif @@arr.include?(@@third) == true
        @@guess_arr[2] = 'p'
      else
        @@guess_arr[2] = 'x'
    end
    if @@fourth == @@arr[3]
        @@guess_arr[3] = 'c'
      elsif @@arr.include?(@@fourth) == true
        @@guess_arr[3] = 'p'
      else
        @@guess_arr[3] = 'x'
    end
    puts "Results: "
    print @@guess_arr
    puts
    if @@guess_arr == ["c", "c", "c", "c"]
      puts "You win!"
      if @@turn == 1
        puts "It took you 1 turn!"
      else
        puts "It took you #{@@turn} turns!"
      end
      @@game_over = true
    end
  end

end

game = Mastermind.new