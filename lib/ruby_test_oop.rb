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

  def initialize(width, height)
    raise ArgumentError, 'Invalid width' unless (0..MAX_WIDTH).include? width
    raise ArgumentError, 'Invalid height' unless (0..MAX_HEIGHT).include? height

    @image = Array.new(height) { Array.new(width, DEFAULT_COLOUR) }
  end

  # Returns the value of a cell inside of the matrix
  def [](x_coordinate, y_coordinate)
    raise ArgumentError, 'Invalid coordinates' unless valid_coordinates?(x_coordinate, y_coordinate)

    @image[y_coordinate - 1][x_coordinate - 1]
  end

  # Sets the value of a cell inside of the matrix
  def []=(x_coordinate, y_coordinate, colour)
    raise ArgumentError, 'Invalid coordinates!' unless valid_coordinates?(x_coordinate, y_coordinate)
    raise ArgumentError, 'Missing colour.' unless colour

    @image[y_coordinate - 1][x_coordinate - 1] = colour
  end
end

# Class for creating and editing the final image
class EditImage < Image
  # Checks for whether the entered coordinates are within bounds and not nil
  def valid_coordinates?(x_coord, y_coord)
    (0..width).include?(x_coord) && (0..height).include?(y_coord)
  end

  # Return all cell values to default values
  def clear
    raise ArgumentError, 'Matrix does not exist, or is invalid.' if @image.nil?

    width.times do |i|
      height.times do |j|
        self[i, j] = DEFAULT_COLOUR
      end
    end
  end

  # Display the current state of the matrix
  def to_s
    @image.map(&:join).join "\n"
  end

  # Draws a vertical line inside of the matrix, based on colour
  def vertical_line(column, first_row, second_row, colour)
    raise ArgumentError, 'Invalid starting position.' unless valid_coordinates?(first_row, column)
    raise ArgumentError, 'Invalid end position.' unless valid_coordinates?(second_row, column)
    raise ArgumentError, 'Colour not set.' unless colour

    (first_row..second_row).each do |i|
      self[column, i] = colour
    end
  end

  # Draws a horizontal line inside of the matrix, based on colour
  def horizontal_line(first_column, second_column, row, colour)
    raise ArgumentError, 'Invalid starting position.' unless valid_coordinates?(row, first_column)
    raise ArgumentError, 'Invalid end position.' unless valid_coordinates?(row, second_column)
    raise ArgumentError, 'Colour not set.' unless colour

    (first_column..second_column).each do |j|
      self[j, row] = colour
    end
  end

  # Changes values of neighbouring cells based on the cell with value [row, column], with a colour of choice
  def fill(row, column, colour, memo = [])
    start_colour = self[row, column]
    self[row, column] = colour

    memo.push([row, column]) # adds coordinates to memo

    (row - 1..row + 1).each do |i|
      (column - 1..column + 1).each do |j|
        next unless valid_coordinates?(i, j)
        next if memo.include? [i, j]
        next unless self[i, j] == start_colour

        fill(i, j, colour, memo)
      end
    end
  end

  # Returns the height of the matrix
  def height
    @image.length
  end

  # Returns the width of the matrix
  def width
    @image[0].length
  end

  private :height, :width
end

# Initialize matrix with nil
image = nil

# loop used for checking whether user wants to exit the program
loop do
  # getting user input and storing values into variables
  command, *args = gets.split

  if command != 'I' && !image
    warn 'Initialize matrix first.'
    next
  end

  args[0] &&= args[0].to_i
  args[1] &&= args[1].to_i

  begin
    case command # checking for commands
    when 'I' then image = EditImage.new(args[0], args[1])
    when 'C' then image.clear
    when 'S' then puts image
    when 'L' then image[args[0], args[1]] = args[2]
    when 'V' then image.vertical_line(args[0], args[1], args[2].to_i, args[3])
    when 'H' then image.horizontal_line(args[0], args[1], args[2].to_i, args[3])
    when 'F' then image.fill(args[0], args[1], args[2])
    when 'X' then break
    else warn "Invalid: '#{command}' command. Try again."
    end
  rescue StandardError => e # returning error depending on what command got an issue
    warn "Unable to perform '#{command}': #{e}"
  end
end
