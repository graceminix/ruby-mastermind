class Mastermind
  COLORS = ["red", "orange", "yellow", "green", "blue", "purple"]
  @@arr = []
  @@turn = 0
  @@guess_arr = []
  @@guesses_arr = []
  @@game_over = false
  attr_accessor :first, :second, :third, :fourth, :guess_arr

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

  def welcome # introduction to rules
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
      @@guesses_arr[i - 1] = guess
      i += 1
    end
    puts "Your guess was #{@@guesses_arr[0]}, #{@@guesses_arr[1]}, #{@@guesses_arr[2]}, #{@@guesses_arr[3]}."
    @@turn += 1
  end

  def return_information
    @@guess_arr = []
    i = 0
    while i < 4
      if @@guesses_arr[i] == @@arr[i]
        @@guess_arr[i] = 'c'
      end
      i += 1
    end
    j = 0
    while j < 4
      if @@guess_arr[j] != 'c'
        if @@arr.include?(@@guesses_arr[j]) == true
          if duplicate_checker(@@guesses_arr[j]) == false
            @@guess_arr[j] = 'p'
          else
            @@guess_arr[j] = 'x'
          end
        else
          @@guess_arr[j] = 'x'
        end
      end
      j += 1
    end
    puts "Results: "
    print @@guess_arr.shuffle()
    puts
    if @@guesses_arr == @@arr
      puts "You win!"
      if @@turn == 1
        puts "It took you 1 turn!"
      else
        puts "It took you #{@@turn} turns!"
      end
      @@game_over = true
    end
  end

  def duplicate_checker(color)
    if @@arr.count(color) >= @@guesses_arr.count(color)
     false
    else
      computer = @@arr.each_index.select{|i| @@arr[i] == color}
      guesser = @@guesses_arr.each_index.select{|i| @@guesses_arr[i] == color}
      if computer - guesser == []
        true
      else
        diff = guesser - computer
        if @@guesses_arr[diff[0]] == 'p'
          true
        end
      end
    end
  end

end

game = Mastermind.new