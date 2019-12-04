require './lib/password_calculator.rb'

describe PasswordCalculator do
  it 'checks number of digits in criteria is 6' do
    password_calculator = PasswordCalculator.new('123123-223444')
    expect(password_calculator.check_length).to eq(true)
  end

  it 'checks password if within range' do
    password_calculator = PasswordCalculator.new('1-10')
    expect(password_calculator.check_range(5)).to eq(true)
    expect(password_calculator.check_range(11)).to eq(false)
  end

  it 'checks password has adjacent same digits but not part of a larger group' do
    password_calculator = PasswordCalculator.new('1-10')
    expect(password_calculator.check_adjacent_double_digits(523423346.to_s.split(''))).to eq(true)
    expect(password_calculator.check_adjacent_double_digits(546.to_s.split(''))).to eq(false)
    expect(password_calculator.check_adjacent_double_digits(112233.to_s.split(''))).to eq(true)
    expect(password_calculator.check_adjacent_double_digits(123444.to_s.split(''))).to eq(false)
    expect(password_calculator.check_adjacent_double_digits(111122.to_s.split(''))).to eq(true)
    expect(password_calculator.check_adjacent_double_digits(228889.to_s.split(''))).to eq(true)
    expect(password_calculator.check_adjacent_double_digits(218899.to_s.split(''))).to eq(true)
  end

  it 'checks password has non-decreasing digits' do
    password_calculator = PasswordCalculator.new('1-10')
    expect(password_calculator.check_digits_never_decrease(123456.to_s.split(''))).to eq(true)
    expect(password_calculator.check_digits_never_decrease(12341.to_s.split(''))).to eq(false)
  end

  it 'checks all criteria' do
    password_calculator = PasswordCalculator.new('240298-784956')
    expect(password_calculator.check_criteria).to eq(748)
  end
end
