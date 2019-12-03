require './lib/wire_calculator.rb'

describe WireCalculator do
  it 'calculates sequential and final positions for series of movements' do
    wire_calculator = WireCalculator.new(%w[U7 R6 D4 L4])
    wire_calculator.run
    expect(wire_calculator.positions.last).to eq([2, 3])
  end

  it 'calculates downward movements' do
    wire_calculator = WireCalculator.new(%w[D7])
    wire_calculator.run
    expect(wire_calculator.positions.last).to eq([0, -7])
  end

  it 'calculates upward movements' do
    wire_calculator = WireCalculator.new(%w[U1])
    wire_calculator.run
    expect(wire_calculator.positions.last).to eq([0, 1])
  end

  it 'calculates rightward movements' do
    wire_calculator = WireCalculator.new(%w[R6])
    wire_calculator.run
    expect(wire_calculator.positions.last).to eq([6, 0])
    expect(wire_calculator.positions).to eq([[0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0]])
  end

  it 'calculates leftward movements' do
    wire_calculator = WireCalculator.new(%w[L4])
    wire_calculator.run
    expect(wire_calculator.positions.last).to eq([-4, 0])
  end

  it 'calculates number of steps' do
    wire_calculator = WireCalculator.new(%w[R8 U5 L5 D3])
    wire_calculator.run
    expect(wire_calculator.find_distance_by_steps_to_position([3, 3])).to eq(20)
  end
end
describe Mesh do
  it 'calculates mesh distances' do
    wire_calculator1 = WireCalculator.new(%w[R8 U5 L5 D3])
    wire_calculator1.run
    wire_calculator2 = WireCalculator.new(%w[U7 R6 D4 L4])
    wire_calculator2.run
    mesh = Mesh.new
    mesh.find_intersection_points(wire_calculator1.positions, wire_calculator2.positions)
    expect(mesh.find_distance).to eq(6)

    wire_calculator3 = WireCalculator.new(%w[R75 D30 R83 U83 L12 D49 R71 U7 L72])
    wire_calculator3.run
    wire_calculator4 = WireCalculator.new(%w[U62 R66 U55 R34 D71 R55 D58 R83])
    wire_calculator4.run
    mesh = Mesh.new
    mesh.find_intersection_points(wire_calculator3.positions, wire_calculator4.positions)
    expect(mesh.find_distance).to eq(159)

    wire_calculator5 = WireCalculator.new(%w[R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51])
    wire_calculator5.run
    wire_calculator6 = WireCalculator.new(%w[U98 R91 D20 R16 D67 R40 U7 R15 U6 R7])
    wire_calculator6.run
    mesh = Mesh.new
    mesh.find_intersection_points(wire_calculator5.positions, wire_calculator6.positions)
    expect(mesh.find_distance).to eq(135)

    input1 = File.readlines('./lib/input1.txt').first.split(',')
    input2 = File.readlines('./lib/input2.txt').first.split(',')
    wire_calculator7 = WireCalculator.new(input1)
    wire_calculator7.run
    wire_calculator8 = WireCalculator.new(input2)
    wire_calculator8.run
    mesh = Mesh.new
    mesh.find_intersection_points(wire_calculator7.positions, wire_calculator8.positions)
    expect(mesh.find_distance).to eq(232)
  end

  it 'calculates step distances between two points' do
    wire_calculator1 = WireCalculator.new(%w[R8 U5 L5 D3])
    wire_calculator1.run

    wire_calculator2 = WireCalculator.new(%w[U7 R6 D4 L4])
    wire_calculator2.run

    mesh = Mesh.new
    mesh.find_intersection_points(wire_calculator1.positions, wire_calculator2.positions)
    intersection = mesh.find_distance_by_steps(wire_calculator1, wire_calculator2)
    expect(intersection).to eq(30)

    wire_calculator3 = WireCalculator.new(%w[R75 D30 R83 U83 L12 D49 R71 U7 L72])
    wire_calculator3.run

    wire_calculator4 = WireCalculator.new(%w[U62 R66 U55 R34 D71 R55 D58 R83])
    wire_calculator4.run

    mesh = Mesh.new
    mesh.find_intersection_points(wire_calculator3.positions, wire_calculator4.positions)
    intersection = mesh.find_distance_by_steps(wire_calculator3, wire_calculator4)
    expect(intersection).to eq(610)

    wire_calculator5 = WireCalculator.new(%w[R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51])
    wire_calculator5.run

    wire_calculator6 = WireCalculator.new(%w[U98 R91 D20 R16 D67 R40 U7 R15 U6 R7])
    wire_calculator6.run

    mesh = Mesh.new
    mesh.find_intersection_points(wire_calculator5.positions, wire_calculator6.positions)
    intersection = mesh.find_distance_by_steps(wire_calculator5, wire_calculator6)
    expect(intersection).to eq(410)

    input1 = File.readlines('./lib/input1.txt').first.split(',')
    input2 = File.readlines('./lib/input2.txt').first.split(',')
    wire_calculator7 = WireCalculator.new(input1)
    wire_calculator7.run
    wire_calculator8 = WireCalculator.new(input2)
    wire_calculator8.run
    mesh = Mesh.new
    mesh.find_intersection_points(wire_calculator7.positions, wire_calculator8.positions)
    intersection = mesh.find_distance_by_steps(wire_calculator7, wire_calculator8)
    expect(intersection).to eq(6084)
  end
end
