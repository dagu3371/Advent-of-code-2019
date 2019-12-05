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

  it 'calculates from file' do
    calculator = GravityCalculator.new(File.readlines('./lib/input3.txt'))
    calculator.run
    expect(calculator.output).to eq(9775037)
  end

  it 'runs file calculations until result is found' do
    calculator = GravityCalculator.new(File.readlines('./lib/input.txt'))
    expect(calculator.run_iteratively(19690720)).to eq(6472)
  end

  it 'calculates for gravity multiplication with params' do
    expect(GravityCalculator.new([1002, 4, 3, 4, 33]).run).to eq([1002, 4, 3, 4, 99])
  end

  it 'calculates for gravity addition with params' do
    expect(GravityCalculator.new([1001, 4, 3, 4, 33, 99]).run).to eq([1001, 4, 3, 4, 36, 99])
    expect(GravityCalculator.new([1101, 100, -1, 4, 0]).run).to eq([1101, 100, -1, 4, 99])
  end

  it 'calculates for gravity with opcode 3 and 4' do
    expect(GravityCalculator.new([3, 0, 4, 0, 99]).run).to eq([1, 0, 4, 0, 99])
  end

  it 'calculates for gravity with opcode 5' do
    calc = GravityCalculator.new([5, 1, 3, 4, 99])
    calc.run
    expect(calc.instruction_pointer).to eq(4)
  end

  it 'calculates for gravity equal or less than' do
    calc = GravityCalculator.new([3,9,8,9,10,9,4,9,99,-1,8])
    calc.initial_input = 0
    calc.run
    expect(calc.output).to eq(0)

    calc = GravityCalculator.new([3,9,8,9,10,9,4,9,99,-1,8])
    calc.initial_input = 8
    calc.run
    expect(calc.output).to eq(1)

    calc = GravityCalculator.new([3,9,7,9,10,9,4,9,99,-1,8])
    calc.initial_input = 9
    calc.run
    expect(calc.output).to eq(0)

    calc = GravityCalculator.new([3,9,7,9,10,9,4,9,99,-1,8])
    calc.initial_input = 1
    calc.run
    expect(calc.output).to eq(1)

    calc = GravityCalculator.new([3,3,1108,-1,8,3,4,3,99])
    calc.initial_input = 8
    calc.run
    expect(calc.output).to eq(1)

    calc = GravityCalculator.new([3,3,1108,-1,8,3,4,3,99])
    calc.initial_input = 1
    calc.run
    expect(calc.output).to eq(0)

    calc = GravityCalculator.new([3,3,1107,-1,8,3,4,3,99])
    calc.initial_input = 1
    calc.run
    expect(calc.output).to eq(1)

    calc = GravityCalculator.new([3,3,1107,-1,8,3,4,3,99])
    calc.initial_input = 9
    calc.run
    expect(calc.output).to eq(0)
  end

  it 'calculates for gravity jump' do
    calc = GravityCalculator.new([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9])
    calc.initial_input = 0
    calc.run
    expect(calc.output).to eq(0)

    calc = GravityCalculator.new([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9])
    calc.initial_input = 2
    calc.run
    expect(calc.initial_input).to eq(2)
    expect(calc.output).to eq(1)

    calc = GravityCalculator.new([3,3,1108,-1,8,3,4,3,99])
    calc.initial_input = 8
    calc.run
    expect(calc.output).to eq(1)

    calc = GravityCalculator.new([3,3,1108,-1,8,3,4,3,99])
    calc.initial_input = 1
    calc.run
    expect(calc.output).to eq(0)
  end

  it 'calculates for gravity with opcode 6' do
    calc = GravityCalculator.new([6, 0, 3, 4, 99])
    calc.run
    expect(calc.instruction_pointer).to eq(0)
  end

  it 'calculates for gravity with opcode 7' do
    expect(GravityCalculator.new([7, 4, 6, 2, 99, 99, 1]).run).to eq([7, 4, 0, 2, 99, 99, 1])
  end

  it 'calculates for gravity with opcode 8' do
    expect(GravityCalculator.new([8, 4, 5, 2, 99, 99]).run).to eq([8, 4, 1, 2, 99, 99])
  end

  it 'processes parameters' do
    calc = GravityCalculator.new([1002, 4, 3, 4, 33])
    calc.process_parameters('1002')
    expect(calc.opcode).to eq(2)
    expect(calc.parameter1).to eq(0)
    expect(calc.parameter2).to eq(1)
    expect(calc.parameter3).to eq(0)

    calc.process_parameters('2')
    expect(calc.opcode).to eq(2)
    expect(calc.parameter1).to eq(0)
    expect(calc.parameter2).to eq(0)
    expect(calc.parameter3).to eq(0)

    calc.process_parameters('123')
    expect(calc.opcode).to eq(23)
    expect(calc.parameter1).to eq(1)
    expect(calc.parameter2).to eq(0)
    expect(calc.parameter3).to eq(0)
  end
end
