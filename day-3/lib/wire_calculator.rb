class Mesh
  attr_reader :intersections
  def initialize
    @intersections = [[0, 0]]
  end

  def find_intersection_points(positions1, positions2)
    @intersections = (positions1 & positions2).sort
  end

  def find_distance
    intersections.map do |intersection|
      unless intersection[0].zero? && intersection[1].zero?
        calculate_distance(intersection)
      end
    end.compact.min
  end

  def find_distance_by_steps(wire1, wire2)
    steps = intersections.map do |array|
      unless array[0].zero? && array[1].zero?
        s = (wire1.find_distance_by_steps_to_position(array) + wire2.find_distance_by_steps_to_position(array))
        { s => array }
      end
    end.compact
    steps.map(&:keys).flatten.min
  end

  def calculate_distance(intersection)
    intersection[0].abs + intersection[1].abs
  end
end

class WireCalculator
  attr_reader :inputs, :positions
  def initialize(inputs)
    @inputs = inputs
    @positions = [[0, 0]]
  end

  def run
    inputs.each do |action|
      movement, distance = action.strip.split('', 2)
      distance = distance.to_i
      case movement
      when 'U'
        move_up(distance)
      when 'D'
        move_down(distance)
      when 'R'
        move_right(distance)
      when 'L'
        move_left(distance)
      end
    end
  end

  def x_value
    positions.last[0]
  end

  def y_value
    positions.last[1]
  end

  def move_up(distance)
    distance.times do
      positions << [x_value, y_value + 1]
    end
  end

  def move_right(distance)
    distance.times do
      positions << [x_value + 1, y_value]
    end
  end

  def move_left(distance)
    distance.times do
      positions << [x_value - 1, y_value]
    end
  end

  def move_down(distance)
    distance.times do
      positions << [x_value, y_value - 1]
    end
  end

  def find_distance_by_steps_to_position(end_point)
    positions[0..positions.index(end_point)].size - 1
  end
end
