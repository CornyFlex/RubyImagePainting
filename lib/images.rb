# frozen_string_literal: true

# This program is made for inputting commands and outputting the image as a matrix in an interactive environment
#
# The program only works with capital letters!

# Class for creating the matrix and changing/getting individual cell value
class Image
  # Set maximum width and height of the matrix.
  MAX_WIDTH = MAX_HEIGHT = 250

  # Set default colour of the cells inside the matrix.
  DEFAULT_COLOUR = 'O'

  def initialize(
    width: self.class::MAX_WIDTH,
    height: self.class::MAX_HEIGHT,
    colour: self.class::DEFAULT_COLOUR
  )
    raise ArgumentError, 'invalid width' unless (0..self.class::MAX_WIDTH).include? width
    raise ArgumentError, 'invalid height' unless (0..self.class::MAX_HEIGHT).include? height

    @colour = colour
    @image = Array.new(height) { Array.new(width, @colour) }
  end

  # Returns the value of a cell inside of the matrix
  def [](x_coordinate, y_coordinate)
    raise ArgumentError, 'invalid coordinates' unless valid_coordinates?(x_coordinate, y_coordinate)

    @image[y_coordinate - 1][x_coordinate - 1]
  end

  # Sets the value of a cell inside of the matrix
  def []=(x_coordinate, y_coordinate, colour)
    raise ArgumentError, 'invalid coordinates' unless valid_coordinates?(x_coordinate, y_coordinate)
    raise ArgumentError, 'missing colour' unless colour

    @image[y_coordinate - 1][x_coordinate - 1] = colour
  end

  # Checks for whether the entered coordinates are within bounds and not nil
  def valid_coordinates?(x_coord, y_coord)
    (0..width).include?(x_coord) && (0..height).include?(y_coord)
  end

  # Display the current state of the matrix
  def to_s
    @image.map(&:join).join("\n")
  end

  # Returns the height of the matrix
  def height
    @image.length
  end

  # Returns the width of the matrix
  def width
    @image[0].length
  end
end

# Class for creating and modifying the final image
class DrawableImage < Image

  # Return all cell values to default values
  def clear
    width.times do |i|
      height.times do |j|
        self[i, j] = @colour
      end
    end
  end

  # Draws a vertical line inside of the matrix, based on colour
  def vertical_line(column, first_row, second_row, colour)
    raise ArgumentError, 'invalid starting position' unless valid_coordinates?(first_row, column)
    raise ArgumentError, 'invalid end position' unless valid_coordinates?(second_row, column)
    raise ArgumentError, 'colour not set' unless colour

    (first_row..second_row).each do |i|
      self[column, i] = colour
    end
  end

  # Draws a horizontal line inside of the matrix, based on colour.
  def horizontal_line(first_column, second_column, row, colour)
    raise ArgumentError, 'invalid starting position' unless valid_coordinates?(row, first_column)
    raise ArgumentError, 'invalid end position' unless valid_coordinates?(row, second_column)
    raise ArgumentError, 'colour not set' unless colour

    (first_column..second_column).each do |j|
      self[j, row] = colour
    end
  end

  # Changes values of neighbouring cells based on the cell with value [row, column], with a colour of choice.
  def fill(row, column, colour, memo = [])
    start_colour = self[row, column]
    self[row, column] = colour

    memo.push([row, column]) # adds coordinates to memo
    p memo
    (row - 1..row + 1).each do |i|
      (column - 1..column + 1).each do |j|
        next unless valid_coordinates?(i, j)
        next if memo.include? [i, j]
        next unless self[i, j] == start_colour

        fill(i, j, colour, memo)
      end
    end
  end
end