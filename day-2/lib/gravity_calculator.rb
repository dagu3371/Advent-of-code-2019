class GravityCalculator
  attr_reader :inputs
  def initialize(inputs)
    @inputs = parse_inputs(inputs)
  end

  def parse_inputs(inputs)
    if inputs.first.is_a? String
      inputs.first.split(",").map(&:to_i)
    else
      inputs
    end
  end

  def run
    run_single_iteration
    inputs
  end

  def run_iteratively(expected_result)
    inputs_array = []
    99.times do |noun|
      99.times do |verb|
        inputs_array << [noun, verb]
      end
    end
    inputs_array.each do |iteration|
      inputs[1] = iteration.first
      inputs[2] = iteration.last
      run_single_iteration
      break if inputs[0] == expected_result

      reset_inputs
    end
    (inputs[1] * 100) + inputs[2]
  end

  def reset_inputs
    @inputs = parse_inputs(File.readlines('./lib/input.txt'))
  end

  def run_single_iteration
    current_index = 0
    until current_index >= inputs.size - 1 || inputs[current_index] == 99
      opcode = inputs[current_index]
      run_addition(current_index) if opcode == 1
      run_multiplication(current_index) if opcode == 2
      current_index += 4
    end
  end

  def run_addition(current_index)
    first_index = inputs[current_index + 1]
    second_index = inputs[current_index + 2]
    changed_index = inputs[current_index + 3]
    inputs[changed_index] = inputs[first_index] + inputs[second_index]
  end

  def run_multiplication(current_index)
    first_index = inputs[current_index + 1]
    second_index = inputs[current_index + 2]
    changed_index = inputs[current_index + 3]
    inputs[changed_index] = inputs[first_index] * inputs[second_index]
  end
end
