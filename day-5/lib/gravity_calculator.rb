class GravityCalculator
  attr_accessor :inputs, :opcode, :parameter1, :parameter2, :parameter3, :initial_input, :instruction_pointer, :output, :update_pointer
  def initialize(inputs)
    @inputs = parse_inputs(inputs)
    @opcode = 0
    @parameter1 = 0
    @parameter2 = 0
    @parameter3 = 0
    @initial_input = 1
    @instruction_pointer = 0
    @output = 0
    @update_pointer = false
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
      process_parameters(inputs[current_index].to_s)
      run_addition(current_index) if @opcode == 1
      run_multiplication(current_index) if @opcode == 2
      run_save(current_index) if @opcode == 3
      run_output(current_index) if @opcode == 4
      update_instruction_pointer(current_index) if @opcode == 5 || @opcode == 6
      less_than_output(current_index) if @opcode == 7
      equal_output(current_index) if @opcode == 8
      if (@opcode == 1 || @opcode == 2 || @opcode == 7 || @opcode == 8)
        current_index += 4
      elsif (@opcode == 5 || @opcode == 6)
        if @update_pointer == true
          current_index = @instruction_pointer
        else
          current_index += 3
        end
      else
        current_index += 2
      end
    end
  end

  def process_parameters(instruction_code)
    code_length = instruction_code.length - 1
    instruction_params = instruction_code.split('')
    @opcode = instruction_params[(code_length - 1)..code_length].join.to_i
    @parameter1 = instruction_params[-3].nil? ? 0 : instruction_params[-3].to_i
    @parameter2 = instruction_params[-4].nil? ? 0 : instruction_params[-4].to_i
    @parameter3 = instruction_params[-5].nil? ? 0 : instruction_params[-5].to_i
  end

  def update_instruction_pointer(current_index)
    @update_pointer = false
    first_val = first_parameter(current_index)
    opcode5_condition = (@opcode == 5 && !first_val.zero?)
    opcode6_condition = (@opcode == 6 && first_val.zero?)
    if opcode5_condition || opcode6_condition
      @update_pointer = true
      @instruction_pointer = second_parameter(current_index)
    end
  end

  def run_save(current_index)
    changed_index = inputs[current_index + 1]
    inputs[changed_index] = @initial_input
  end

  def less_than_output(current_index)
    first_val = first_parameter(current_index)
    second_val = second_parameter(current_index)
    changed_index = inputs[current_index + 3]
    output_value = first_val < second_val ? 1 : 0
    inputs[changed_index] = output_value
  end

  def equal_output(current_index)
    first_val = first_parameter(current_index)
    second_val = second_parameter(current_index)
    changed_index = inputs[current_index + 3]
    output_value = first_val == second_val ? 1 : 0
    inputs[changed_index] = output_value
  end

  def run_output(current_index)
    first_val = first_parameter(current_index)
    @output = first_val
    p first_val
  end

  def run_addition(current_index)
    first_val, second_val, changed_index = process_operation_values(current_index)
    inputs[changed_index] = first_val + second_val
  end

  def run_multiplication(current_index)
    first_val, second_val, changed_index = process_operation_values(current_index)
    inputs[changed_index] = first_val * second_val
  end

  def first_parameter(current_index)
    @parameter1.zero? ? inputs[inputs[current_index + 1]] : inputs[current_index + 1]
  end

  def second_parameter(current_index)
    @parameter2.zero? ? inputs[inputs[current_index + 2]] : inputs[current_index + 2]
  end

  def process_operation_values(current_index)
    first_val = first_parameter(current_index)
    second_val = second_parameter(current_index)
    changed_index = inputs[current_index + 3]
    [first_val, second_val, changed_index]
  end
end
