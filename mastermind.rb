class Mastermind
  COLORS = ["red", "orange", "yellow", "green", "blue", "purple"]
  @@arr = []
  @@turn = 0
  @@guess_arr = []
  @@guesses_arr = []
  @@game_over = false
  @@choice = nil
  @@rando_arr = []
  attr_accessor :first, :second, :third, :fourth, :guess_arr

  def initialize
    puts 'Welcome to Mastermind!'
    puts 'Would you like to be the codebreaker or the creator?'
    puts "Enter '1' to be the creator and '2' to be the codebreaker."
    @@choice = gets.chomp.to_i
    until @@choice == 1 || @@choice == 2
      puts 'Please choose 1 or 2.'
      @@choice = gets.chomp.to_i
    end
    if @@choice == 2
      puts 'You have chosen to be the codebreaker!'
      codebreaker
    else
      puts 'You have chosen to be the creator!'
      creator
    end
  end

  def codebreaker
    i = 0
    while i < 4
      @@arr.push(COLORS.sample)
      i += 1
    end
    welcome
    play
  end

  def creator
    setup
    play
  end

  private 

  def setup # introduction to rules
    welcome
    i = 1
    while i < 5
      puts "Please select the #{i} color: "
      guess = gets.chomp.downcase
      until COLORS.include?(guess) == true
        puts 'Please choose a valid color'
        guess = gets.chomp.downcase
      end
      @@arr[i - 1] = guess
      i += 1
    end
    puts 'The following is the combination you have chosen.'
    print @@arr
    puts
  end

  public 

  def welcome # introduction to rules
    puts 'The creator will choose four random colors out of the following: '
    puts 'Red, orange, yellow, green, blue, purple'
    puts 'Duplicate colors are allowed.'
    puts 'The codebreaker will have 12 guesses to get the correct order and colors.'
    puts 'After each guess, the computer will give the player an output.'
    puts "A 'c' means that the color and placement are correct."
    puts "A 'p' means the color is correct but the placement is incorrect."
    puts "An 'x' means that neither color or placment is correct."
    puts 'The array the computer outputs is randomized.'
    puts "That means, a 'c' in index 0 does not mean that the first color you guessed is correct."
    puts "Let's go!"
  end

  def play
    while @@game_over == false && @@turn < 12
      if @@choice == 2
        guess_order
      else
        computer_guess
      end
      return_information
    end
    if @@turn >= 12 && @@choice == 2
      puts 'You lose!'
      puts 'The correct answer was: '
      print @@arr
      puts
    else
      puts 'You win!'
      puts 'Congratulations!'
    end
  end

  def computer_guess
    @@guesses_arr = []
    if @@turn < 12
      i = 0
      while i < 4
        @@guesses_arr.push(COLORS.sample)
        i += 1
      end
    else
      puts @@rando_arr
      smart_guess
    end
    puts "Computer's guess: "
    print @@guesses_arr
    puts
    @@turn += 1
  end

  def smart_guess
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
    @@rando_arr = @@guess_arr.shuffle()
    print @@rando_arr
    puts
    puts "This was the #{@@turn} guess."
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