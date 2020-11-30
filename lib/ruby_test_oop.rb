# frozen_string_literal: true

# This program is made for inputting commands and outputting the image as a matrix in an interactive environment

# The program only works with capital letters!

# Initializing variable for storing the command name
command_name = ''

# Class for creating and editing the final image
class Matrix
  def initialize(width, height)
    @image = create_matrix(width, height)
  end

  def valid_coordinates?(width, height, additional_width = 0, additional_height = 0)
    true if width <= image_width && additional_width <= image_width && height <= image_height && additional_height <= image_height
  end

  # creates and returns matrix based on width and height
  def create_matrix(width, height)
    return unless width && height <= 250

    Array.new(height) { Array.new(width) { 'O' } }
  end

  # return values in current matrix back to default
  def clear_matrix
    @image = Array.new(image_height) { Array.new(image_width) { 'O' } }
  end

  # display matrix
  def display_matrix
    @image.map { |value| puts value.join }
  end
  
  # changes values (colour) of a specific field
  def colour_field(x_coordinate, y_coordinate, colour)
    return unless valid_coordinates?(x_coordinate, y_coordinate)

    return if x_coordinate.nil? || y_coordinate.nil? || colour.nil?

    set_colour(x_coordinate, y_coordinate, colour)
    @image
  end

  # draws a vertical segment based on given input
  def vertical_segment(column, first_row, second_row, colour)
    return unless valid_coordinates?(column, first_row, 0, second_row)

    return if column.nil? || first_row.nil? || second_row.nil? || colour.nil?

    (first_row..second_row).each do |i|
      set_colour(column, i, colour)
    end
    @image
  end

  # draws a horizontal segment based on input
  def horizontal_segment(first_column, second_column, row, colour)
    return unless valid_coordinates?(first_column, row, second_column, 0)

    return if first_column.nil? || second_column.nil? || row.nil? || colour.nil?

    (first_column..second_column).each do |j|
      set_colour(j, row, colour)
    end
    @image
  end

  # fills in the matrix depending on the colour of a field
  def fill_matrix(x_coordinate, y_coordinate, colour, memo=[])
    return unless valid_coordinates?(x_coordinate, y_coordinate)

    return if x_coordinate.nil? || y_coordinate.nil? || colour.nil?

    memo.push([x_coordinate, y_coordinate]) # add us to the memo

    (x_coordinate - 1..x_coordinate + 1).each do |i|
      (y_coordinate - 1..y_coordinate + 1).each do |j|
        next if memo.include? [i, j]

        if get_colour(i, j) == get_colour(x_coordinate, y_coordinate)
          fill_matrix(i, j, colour, memo)
          set_colour(i, j, colour)
        end
      end
    end
    set_colour(x_coordinate, y_coordinate, colour)
  end

  def image_height
    @image.length
  end

  def image_width
    @image[0].length
  end

  def get_colour(x_coordinate, y_coordinate)
    @image[y_coordinate - 1][x_coordinate - 1]
  end

  def set_colour(x_coordinate, y_coordinate, colour)
    @image[y_coordinate - 1][x_coordinate - 1] = colour
  end

  private :image_height, :image_width, :get_colour, :set_colour
end

# loop used for checking whether user wants to exit the program
while command_name != 'X'

  # getting user input and storing values into variables
  command_name, first_variable, second_variable, third_variable, fourth_variable = gets.split

  case command_name # checking for commands
  when 'I' # used for creating a matrix
    width = first_variable.to_i
    height = second_variable.to_i

    image = Matrix.new(width, height)
    puts 'Error creating matrix' if image.nil?
  when 'C' # used for clearing out any values inside of the matrix
    puts 'Error clearing out the matrix.' if image&.clear_matrix.nil?
  when 'S' # displays current state of the matrix
    puts 'Error displaying the matrix.' if image&.display_matrix.nil?
  when 'L' # used for changing the value (colour) of a single field in the matrix
    if image&.colour_field(first_variable.to_i, second_variable.to_i, third_variable).nil?
      puts 'Error changing the value of a field in the matrix.'
    end
  when 'V' # used for drawing a vertical line in the matrix
    if image&.vertical_segment(first_variable.to_i, second_variable.to_i, third_variable.to_i, fourth_variable).nil?
      puts 'Error drawing a vertical line in the matrix.'
    end
  when 'H' # used for drawing a horizontal line in the matrix
    if image&.horizontal_segment(first_variable.to_i, second_variable.to_i, third_variable.to_i, fourth_variable).nil?
      puts 'Error drawing a horizontal line in the matrix.'
    end
  when 'F' # used for filling in the matrix depending on the colour of a field
    if image&.fill_matrix(first_variable.to_i, second_variable.to_i, third_variable).nil?
      puts 'Error filling in the matrix.'
    end
  when 'X' # used for exiting the program
    break
  else
    puts 'Error, wrong command name. Try again.'
  end
end
