require_relative 'images'

def run_command(command, *args)
  case command
  when 'I' then @image = DrawableImage.new(width: args[0].to_i, height: args[1].to_i)
  when 'C' then @image.clear
  when 'S' then puts @image
  when 'L' then @image[args[0].to_i, args[1].to_i] = args[2]
  when 'V' then @image.vertical_line(args[0].to_i, args[1].to_i, args[2].to_i, args[3])
  when 'H' then @image.horizontal_line(args[0].to_i, args[1].to_i, args[2].to_i, args[3])
  when 'F' then @image.fill(args[0].to_i, args[1].to_i, args[2])
  when 'X' then return false
  else warn "Invalid: '#{command}' command. Try again."
  end

  true

rescue StandardError => e # returning error depending on what command got an issue
  warn "Unable to perform '#{command}': #{e}"
  puts e.full_message if $DEBUG
  true
end

# Initialize matrix with nil
@image = nil

# loop used for checking whether user wants to exit the program
loop do
  # getting user input and storing values into variables
  command, *args = gets.split

  if command != 'I' && !@image
    warn 'initialize matrix first'
    next
  end

  break unless run_command(command, *args)
end
