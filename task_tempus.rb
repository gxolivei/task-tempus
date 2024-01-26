STYLES = {
  reset: "\e[0m",
  bold: "\e[1m",
  underline: "\e[4m",
  red: "\e[31m",
  yellow: "\e[33m",
  cyan: "\e[36m"
}

CLEAR_COMMAND = RUBY_PLATFORM =~ /win32/ ? 'cls' : 'clear'

PERCENTAGES = [20, 60, 80]

SECONDS_PER_HOUR = 3600
SECONDS_PER_MINUTE = 60

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
        puts "\n#{STYLES[:bold]}#{STYLES[:yellow]}Invalid input. Please enter your dev name.#{STYLES[:reset]}"
      else
        puts "\n#{STYLES[:bold]}#{STYLES[:yellow]}Invalid input. Please enter the task.#{STYLES[:reset]}"
      end
    else
      return input
    end
  end
end

def get_dev_name
  get_non_empty_input("\n#{STYLES[:bold]}#{STYLES[:cyan]}Enter your dev name:#{STYLES[:reset]} ")
end

def get_task
  get_non_empty_input("\n#{STYLES[:bold]}#{STYLES[:cyan]}Enter the task:#{STYLES[:reset]} ")
end


def get_hours_input
  get_positive_integer_input("\n#{STYLES[:bold]}#{STYLES[:cyan]}Enter the amount of time available in hours (minimum is 1 hour):#{STYLES[:reset]} ")
end

def clear_terminal
  system(CLEAR_COMMAND)
end

def display_countdown(percentage, display_time)
  print "\r#{STYLES[:bold]}#{STYLES[:cyan]}#{percentage}% completion - You have #{display_time} remaining#{STYLES[:reset]}"
end

def countdown_display(total_seconds)
  PERCENTAGES.each do |percentage|
    time_remaining = (total_seconds * percentage / 100).to_i

    puts "#{STYLES[:bold]}#{STYLES[:yellow]}Countdown to #{percentage}% completion of the task:#{STYLES[:reset]}"
    puts "\n"

    time_remaining.downto(0) do |remaining_seconds|
      hours_left = remaining_seconds / SECONDS_PER_HOUR
      minutes_left = (remaining_seconds % SECONDS_PER_HOUR) / SECONDS_PER_MINUTE
      seconds_left = remaining_seconds % SECONDS_PER_MINUTE

      display_time = format('%02d:%02d:%02d', hours_left, minutes_left, seconds_left)
      display_countdown(percentage, display_time)

      sleep(1)
    end

    puts "\n\n"
  end
end

def display_user_details(dev_name, task, hours)
  puts "\nThank you, #{STYLES[:bold]}#{STYLES[:cyan]}#{dev_name}!#{STYLES[:reset]} You've entered the following details:"
  puts "\nTask: #{STYLES[:bold]}#{STYLES[:cyan]}#{task}#{STYLES[:reset]}"
  puts "Time Available: #{STYLES[:bold]}#{STYLES[:cyan]}#{hours} #{hours == 1 ? 'hour' : 'hours'}#{STYLES[:reset]}"
  puts "Deadline in #{STYLES[:bold]}#{STYLES[:cyan]}#{format('%02d:%02d:%02d', hours, 0, 0)}#{STYLES[:reset]}"
  puts "\n"
end

def run_countdown
  puts "\n#{STYLES[:bold]}#{STYLES[:cyan]}Welcome to the Countdown Clock program!#{STYLES[:reset]}"
  puts "#{STYLES[:bold]}This program helps you manage your time by providing countdowns for different task completion percentages.#{STYLES[:reset]}"
  puts "#{STYLES[:bold]}#{STYLES[:underline]}You can enter your information below to get started.#{STYLES[:reset]}"

  proceed = get_user_input("\n#{STYLES[:bold]}#{STYLES[:yellow]}Do you want to proceed? (Y/N):#{STYLES[:reset]} ").downcase

  if proceed == 'y'
    dev_name = get_dev_name
    task = get_task
    hours = get_hours_input

    clear_terminal

    display_user_details(dev_name, task, hours)

    countdown_display(hours * SECONDS_PER_HOUR)
  else
    puts "\n#{STYLES[:bold]}#{STYLES[:red]}Exiting the program. Goodbye!#{STYLES[:reset]}" 
  end
end

run_countdown
