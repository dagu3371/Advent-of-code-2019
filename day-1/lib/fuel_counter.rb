class FuelCounterUpper
  attr_reader :inputs
  def initialize(inputs)
    @inputs = inputs
  end

  def process_inputs
    inputs.map { |fuel| run(fuel) }.sum
  end

  def process_additional_inputs
    fuel_array = []
    inputs.each do |fuel|
      while requires_additional_fuel?(fuel)
        fuel_array << run(fuel) if requires_additional_fuel?(run(fuel))
        fuel = run(fuel)
      end
    end
    fuel_array.sum
  end

  def run(fuel_count)
    (fuel_count.to_i/3).floor - 2
  end

  def requires_additional_fuel?(fuel_count)
    fuel_count.to_i > 0
  end
end
