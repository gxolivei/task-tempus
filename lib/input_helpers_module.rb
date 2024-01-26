module InputHelpers
  include Styling

  def get_user_input(prompt)
    print "#{STYLES[:bold]}#{STYLES[:cyan]}#{prompt}#{STYLES[:reset]}"
    gets.chomp
  end
  
  def get_positive_integer_input(prompt)
    loop do
      input = get_user_input("#{STYLES[:bold]}#{prompt}#{STYLES[:reset]}")
  
      if input.to_i.to_s == input && input.to_i.positive?
        return input.to_i
      else
        puts "\n#{STYLES[:bold]}#{STYLES[:yellow]}Invalid input. Please enter a valid positive number greater than zero.#{STYLES[:reset]}"
      end
    end
  end
  
  def get_non_empty_input(prompt)
    loop do
      input = get_user_input("#{STYLES[:bold]}#{STYLES[:red]}#{prompt}#{STYLES[:reset]}")
      if input.strip.empty?
        if prompt.include?("dev name")
          puts "\n#{STYLES[:bold]}#{STYLES[:yellow]}Invalid input. Please enter your name.#{STYLES[:reset]}"
        else
          puts "\n#{STYLES[:bold]}#{STYLES[:yellow]}Invalid input. Please enter the task.#{STYLES[:reset]}"
        end
      else
        return input
      end
    end
  end
end