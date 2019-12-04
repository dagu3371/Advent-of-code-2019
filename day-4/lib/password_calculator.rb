class PasswordCalculator
  attr_reader :start_input, :end_input, :valid_passwords, :digit_combinations
  def initialize(input)
    @start_input, @end_input = input.split('-')
    @valid_passwords = []
    @digit_combinations = []
  end

  def check_criteria
    (start_input..end_input).to_a.map do |password|
      guess = password.split('')
      store_password(password) if valid_criteria?(password, guess)
    end
    number_of_valid_passwords
  end

  def number_of_valid_passwords
    valid_passwords.compact.size
  end

  def valid_criteria?(password, guess)
    check_length &&
      check_range(password) &&
      check_adjacent_double_digits(guess) &&
      check_digits_never_decrease(guess)
  end

  def store_password(password)
    valid_passwords << password
  end

  def check_length
    start_input.length == 6 && end_input.length == 6
  end

  def check_range(password)
    password.to_i >= start_input.to_i && password.to_i <= end_input.to_i
  end

  def select_duplicates(array)
    array.select { |v| array.count(v) > 1 }
  end

  def check_adjacent_double_digits(guess)
    digit_combinations = []
    duplicates = []
    guess.map.with_index do |digit, index|
      start_index = index - 1 < 0 ? 0 : index - 1
      end_index = index + 1 > guess.length - 1 ? guess.length - 1 : index + 1
      if digit == guess[index + 1] && digit != guess[index + 2]
        digit_combinations << guess[start_index..end_index]
      end
    end
    digit_combinations.each do |combination|
      duplicates << select_duplicates(combination).size if combination.any?
    end
    duplicates.include?(2)
  end

  def check_digits_never_decrease(guess)
    guess.map.with_index do |digit, index|
      unless guess[index + 1].nil?
        return false if digit > guess[index + 1]
      end
    end
    true
  end
end
