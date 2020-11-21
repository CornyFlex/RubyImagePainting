# frozen_string_literal: true

# This program is made for inputting commands and outputting the result as a matrix in an interactive environment

# The program only works with capital letters!

# Initializing variables for storing comamnds and command properties used for calculating and printing matrixes

command_name = ''
first_variable = ''
second_variable = ''
third_variable = ''
fourth_variable = ''
width = ''
height = ''

# defining methods used for calculating and processing input

# creates and returns matrix based on width and height
def create_matrix(width, height)
  return 'Error. Could not create matrix. Try again' unless width && height <= 250

  Array.new(height) { Array.new(width) { 'O' } }
end

# changes values (colour) of a specific field
def colour_field(height, width, colour, matrix)
  if matrix
    matrix[width - 1][height - 1] = colour
    matrix
  else
    puts 'Error, could not colour the field. Try again.'
  end
end

# draws a vertical segment based on given input
def vertical_segment(column, first_row, second_row, colour, matrix)
  if matrix
    (first_row..second_row).each do |i|
      matrix[i - 1][column - 1] = colour
    end
    matrix
  else
    puts 'Error, could not draw vertical line. Try again.'
  end
end

# draws a horizontal segment based on input
def horizontal_segment(first_column, second_column, row, colour, matrix)
  if matrix
    (first_column..second_column).each do |j|
      matrix[row - 1][j - 1] = colour
    end
    matrix
  else
    puts 'Error, could not draw horizontal line. Try again.'
  end
end

# fills in the matrix depending on the colour of a field
def fill_matrix(x_coordinate, y_coordinate, colour, matrix, width, height)
  if matrix
    field_colour = matrix[y_coordinate - 1][x_coordinate - 1]
    (0..width).each do |i|
      (0..height).each do |j|
        matrix[i][j] = colour if matrix[i][j] == field_colour
      end
    end
    matrix
  else
    puts 'Error, could not fill matrix. Try again.'
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

    result = create_matrix(width, height)
  when 'C' # used for clearing out any values inside of the matrix
    if result
      result = Array.new(height) { Array.new(width) { 'O' } }
    else
      puts 'Error, matrix could not be cleared. Try again.'
    end
  when 'S' # displays current state of the matrix
    if result
      result.each do |x|
        puts x.join
      end
    else
      puts 'Error, matrix could not be shown. Try again.'
    end
  when 'L' # used for changing the value (colour) of a single field in the matrix
    result = colour_field(first_variable.to_i, second_variable.to_i, third_variable, result)
  when 'V' # used for drawing a vertical line in the matrix
    result = vertical_segment(first_variable.to_i, second_variable.to_i, third_variable.to_i, fourth_variable, result)
  when 'H' # used for drawing a horizontal line in the matrix
    result = horizontal_segment(first_variable.to_i, second_variable.to_i, third_variable.to_i, fourth_variable, result)
  when 'F' # used for filling in the matrix depending on the colour of a field
    result = fill_matrix(first_variable.to_i, second_variable.to_i, third_variable, result, width, height)
  when 'X' # used for existing the program
    break
  else
    puts 'Error, wrong command name. Try again.'
  end
end
