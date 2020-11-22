# frozen_string_literal: true

# This program is made for inputting commands and outputting the result as a matrix in an interactive environment

# The program only works with capital letters!

# Initializing variables for storing commands and command properties used for calculating and printing the matrix

command_name = ''
first_variable = ''
second_variable = ''
third_variable = ''
fourth_variable = ''

# Class for creating and editing the final result
class Matrix
  def initialize(width, height)
    @width = width
    @height = height
    @result = create_matrix
  end

  # creates and returns matrix based on width and height
  def create_matrix
    return 'Error. Could not create matrix. Try again' unless @width && @height <= 250

    Array.new(@height) { Array.new(@width) { 'O' } }
  end

  # return values in current matrix back to default
  def clear_matrix
    @result = Array.new(@height) { Array.new(@width) { 'O' } }
  end

  # display matrix
  def display_matrix
    @result.each do |x|
      puts x.join
    end
  end

  # changes values (colour) of a specific field
  def colour_field(x_coordinate, y_coordinate, colour)
    @result[y_coordinate - 1][x_coordinate - 1] = colour
    @result
  end

  # draws a vertical segment based on given input
  def vertical_segment(column, first_row, second_row, colour)
    (first_row..second_row).each do |i|
      @result[i - 1][column - 1] = colour
    end
    @result
  end

  # draws a horizontal segment based on input
  def horizontal_segment(first_column, second_column, row, colour)
    (first_column..second_column).each do |j|
      @result[row - 1][j - 1] = colour
    end
    @result
  end

  # fills in the matrix depending on the colour of a field
  def fill_matrix(x_coordinate, y_coordinate, colour)
    field_colour = @result[y_coordinate - 1][x_coordinate - 1]
    (0..@width).each do |i|
      (0..@height).each do |j|
        @result[i][j] = colour if @result[i][j] == field_colour
      end
    end
    @result
  end
end

# loop used for checking whether user wants to exit the program
while command_name != 'X'

  # getting user input and storing values into variables
  command_name, first_variable, second_variable, third_variable, fourth_variable = gets.split

  case command_name # checking for commands
  when 'I' # used for creating a matrix
    width = first_variable.to_i
    height = second_variable.to_i

    result = Matrix.new(width, height)
  when 'C' # used for clearing out any values inside of the matrix
    puts 'Error clearing out the matrix.' if result&.clear_matrix.nil?
  when 'S' # displays current state of the matrix
    puts 'Error displaying the matrix.' if result&.display_matrix.nil?
  when 'L' # used for changing the value (colour) of a single field in the matrix
    if result&.colour_field(first_variable.to_i, second_variable.to_i, third_variable).nil?
      puts 'Error changing the value of a field in the matrix.'
    end
  when 'V' # used for drawing a vertical line in the matrix
    if result&.vertical_segment(first_variable.to_i, second_variable.to_i, third_variable.to_i, fourth_variable).nil?
      puts 'Error drawing a vertical line in the matrix.'
    end
  when 'H' # used for drawing a horizontal line in the matrix
    if result&.horizontal_segment(first_variable.to_i, second_variable.to_i, third_variable.to_i, fourth_variable).nil?
      puts 'Error drawing a horizontal line in the matrix.'
    end
  when 'F' # used for filling in the matrix depending on the colour of a field
    if result&.fill_matrix(first_variable.to_i, second_variable.to_i, third_variable).nil?
      puts 'Error filling in the matrix.'
    end
  when 'X' # used for existing the program
    break
  else
    puts 'Error, wrong command name. Try again.'
  end
end
