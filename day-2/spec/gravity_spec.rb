require './lib/gravity_calculator.rb'

describe GravityCalculator do
  it 'calculates for gravity addition' do
    expect(GravityCalculator.new([1, 0, 0, 0, 99]).run).to eq([2, 0, 0, 0, 99])
    expect(GravityCalculator.new([1, 1, 1, 4, 99, 5, 6, 0, 99]).run).to eq([30, 1, 1, 4, 2, 5, 6, 0, 99])
  end

  it 'calculates for gravity multiplication' do
    expect(GravityCalculator.new([2, 3, 0, 3, 99]).run).to eq([2, 3, 0, 6, 99])
    expect(GravityCalculator.new([2, 4, 4, 5, 99, 0]).run).to eq([2, 4, 4, 5, 99, 9801])
  end

  it 'calculates from file' do
    calculator = GravityCalculator.new(File.readlines('./lib/input.txt'))
    expect(calculator.run.first).to eq(3716250)
  end

  it 'runs file calculations until result is found' do
    calculator = GravityCalculator.new(File.readlines('./lib/input.txt'))
    expect(calculator.run_iteratively(19690720)).to eq(6472)
  end
end
