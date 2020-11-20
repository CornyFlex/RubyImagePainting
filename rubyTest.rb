#This program is made for inputting commands and outputting the result as a matrix in an interactive environment
#the program only works with capital letters!
#initializing variables for storing comamnds and command properties used for calculating and printing matrixes
commandName = ''
firstVariable = ''
secondVariable = ''
thirdVariable = ''
fourthVariable = ''
width = ''
height = ''

#defining methods used for calculating and processing input
def createMatrix(width, height) #creates and returns matrix based on width and height
  if (width && height) <= 250
    matrix = Array.new(height) { Array.new(width) { "O" }}
    return matrix
  end
end

def colourField(height, width, colour, matrix) #changes values (colour) of a specific field
  if matrix
    matrix[width-1][height-1] = colour
    return matrix
  else
    puts "Error, could not colour the field. Try again."
  end
end

def verticalSegment(column, firstRow, secondRow, colour, matrix) #draws a vertical segment based on given input
  if matrix
    for i in firstRow..secondRow
      matrix[i-1][column-1] = colour
    end
    return matrix
  else
    puts "Error, could not draw vertical line. Try again."
  end
end

def horizontalSegment(firstColumn, secondColumn, row, colour, matrix) #draws a horizontal segment based on input
  if matrix
    for j in firstColumn..secondColumn
      matrix[row-1][j-1] = colour
    end
    return matrix
  else
    puts "Error, could not draw horizontal line. Try again."
  end
end

def fillMatrix(xCoordinate, yCoordinate, colour, matrix, width, height) #fills in the matrix depending on the colour of a field
  if matrix
    fieldColour = matrix[yCoordinate-1][xCoordinate-1]
    for i in 0..width
      for j in 0..height
        if matrix[i][j] == fieldColour
          matrix[i][j] = colour
        end
      end
    end
    return matrix
  else
    puts "Error, could not fill matrix. Try again."
  end
end

#loop used for checking whether user wants to exit the program
while (commandName != 'X')

  #getting user input and storing values into variables
  commandName, firstVariable, secondVariable, thirdVariable, fourthVariable = gets().split()

  case commandName #checking for commands
  when 'I' #used for creating a matrix
    width = firstVariable.to_i
    height = secondVariable.to_i

    result = createMatrix(width, height)
  when 'C' #used for clearing out any values inside of the matrix
    if result
      result = Array.new(height) { Array.new(width) { "O" }}
    else
      puts "Error, matrix could not be cleared. Try again."
    end
  when 'S' #displays current state of the matrix
    if result
      result.each do |x|
        puts x.join()
      end
    else
      puts "Error, matrix could not be shown. Try again."
    end
  when 'L' #used for changing the value (colour) of a single field in the matrix
    result = colourField(firstVariable.to_i, secondVariable.to_i, thirdVariable, result)
  when 'V' #used for drawing a vertical line in the matrix
    result = verticalSegment(firstVariable.to_i, secondVariable.to_i, thirdVariable.to_i, fourthVariable, result)
  when 'H' #used for drawing a horizontal line in the matrix
    result = horizontalSegment(firstVariable.to_i, secondVariable.to_i, thirdVariable.to_i, fourthVariable, result)
  when 'F' #used for filling in the matrix depending on the colour of a field
    result = fillMatrix(firstVariable.to_i, secondVariable.to_i, thirdVariable, result, width, height)
  when 'X' #used for existing the program
    break
  else
    puts "Error, wrong command name. Try again."
  end
end
