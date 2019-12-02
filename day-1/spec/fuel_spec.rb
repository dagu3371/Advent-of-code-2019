require './lib/fuel_counter.rb'

describe FuelCounterUpper do
  it 'calculates for fuel' do
    fuel_counter = FuelCounterUpper.new([12,12])
    expect(fuel_counter.run(12)).to eq(2)
    expect(fuel_counter.run(14)).to eq(2)
    expect(fuel_counter.run(1969)).to eq(654)
    expect(fuel_counter.run(100756)).to eq(33583)
  end

  it 'processes multiple fuel requirements' do
    fuel_counter = FuelCounterUpper.new([12, 12])
    expect(fuel_counter.process_inputs).to eq(4)
  end

  it 'processes multiple fuel requirements from file' do
    fuel_counter = FuelCounterUpper.new(File.readlines('./lib/input.txt'))
    expect(fuel_counter.process_inputs).to eq(3360301)
  end

  it 'processes additional fuel requirements' do
    fuel_counter = FuelCounterUpper.new([1969])
    expect(fuel_counter.process_additional_inputs).to eq(966)
  end

  it 'processes additional fuel requirements' do
    fuel_counter = FuelCounterUpper.new([100756, 1969])
    expect(fuel_counter.process_additional_inputs).to eq(51312)
  end

  it 'processes additional fuel requirements' do
    fuel_counter = FuelCounterUpper.new(File.readlines('./lib/input.txt'))
    expect(fuel_counter.process_additional_inputs).to eq(5037595)
  end
end
