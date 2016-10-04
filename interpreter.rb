arr = [0]

program_pointer = 0
data_pointer = 0

commands = ['>', '<', '+', '-', '.', ',', '[', ']']

program = gets.chomp.split('').select{|x| commands.index x}.join('')

while program_pointer < program.length
  case program[program_pointer]
    when '>'
      data_pointer += 1
      
      arr[data_pointer] ||= 0

    when '<'
      if data_pointer == 0
        puts "Runtime Error: Cannot decrement pointer past 0"
        exit 1
      else
        data_pointer -= 1
      end

    when '+'
      arr[data_pointer] += 1
      
    when '-'
      arr[data_pointer] -= 1

    when '.'
      print arr[data_pointer].chr

    when ','
      input = gets.chomp
      input.split('').each do |x|
        unless [1, 2, 3, 4, 5, 6, 7, 8, 9, 0].index x.to_i
          puts "Runtime Error: Invalid input: #{input}"
          exit 1
        end
      end
      arr[data_pointer] = input.to_i
    when '['
      if arr[data_pointer] != 0
        program_pointer += 1
        next
      end

      num_left = 1
      num_right = 0
      matched = false

      ((program_pointer+1)..(program.length-1)).to_a.each do |index|
        if program[index] == '['
          num_left += 1
        elsif program[index] == ']'
          num_right += 1
        end
        if num_left == num_right
          program_pointer = index
          matched = true
          break
        end
      end
      unless matched
        puts "Runtime Error: Unmatched [ at index: #{program_pointer}"
        exit 1
      end

    when ']'
      if arr[data_pointer] == 0
        program_pointer += 1
        next
      end

      num_left = 0
      num_right = 1
      matched = false

      (0..(program_pointer-1)).to_a.reverse.each do |index|
        if program[index] == '['
          num_left += 1
        elsif program[index] == ']'
          num_right += 1
        end
        if num_left == num_right
          program_pointer = index
          matched = true
          break
        end
      end
      unless matched
        puts "Runtime Error: Unmatched ] at index: #{program_pointer}"
        exit 1
      end
  end
  program_pointer += 1
end
