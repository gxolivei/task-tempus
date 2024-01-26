COLOR_BOLD = "\e[1m"
COLOR_RESET = "\e[0m"
COLOR_BLUE = "\e[34m"
COLOR_GREEN = "\e[32m"
COLOR_CYAN = "\e[36m"
COLOR_YELLOW = "\e[33m"
COLOR_RED = "\e[31m"

CLEAR_COMMAND = RUBY_PLATFORM =~ /win32/ ? 'cls' : 'clear'

PERCENTAGES = [20, 60, 80]

SECONDS_PER_HOUR = 3600
SECONDS_PER_MINUTE = 60

def get_user_input(prompt)
  print "#{COLOR_BOLD}#{COLOR_BLUE}#{prompt}#{COLOR_RESET}"
  gets.chomp
end

def get_hours_input
  loop do
    input = get_user_input("#{COLOR_BOLD}#{COLOR_GREEN}Enter the amount of time available in hours (minimum is 1 hour):#{COLOR_RESET}")

    if input.to_i.to_s == input && input.to_i.positive?
      return input.to_i
    else
      puts "#{COLOR_BOLD}#{COLOR_RED}Invalid input. Please enter a valid positive number for hours.#{COLOR_RESET}"
    end
  end
end

def clear_terminal
  system(CLEAR_COMMAND)
end

def countdown(hours)
  total_seconds = hours * SECONDS_PER_HOUR

  PERCENTAGES.each do |percentage|
    time_remaining = (total_seconds * percentage / 100).to_i

    puts "#{COLOR_BOLD}#{COLOR_YELLOW}Countdown to #{percentage}% completion of the task:#{COLOR_RESET}"
    puts "\n"

    time_remaining.downto(0) do |remaining_seconds|
      hours_left = remaining_seconds / SECONDS_PER_HOUR
      minutes_left = (remaining_seconds % SECONDS_PER_HOUR) / SECONDS_PER_MINUTE
      seconds_left = remaining_seconds % SECONDS_PER_MINUTE

      display_time = format('%02d:%02d:%02d', hours_left, minutes_left, seconds_left)

      case percentage
      when 20
        print "\r#{COLOR_BOLD}#{COLOR_CYAN}20% completion - You have #{display_time} remaining#{COLOR_RESET}"
      when 60
        print "\r#{COLOR_BOLD}#{COLOR_CYAN}60% completion - You have #{display_time} remaining#{COLOR_RESET}"
      when 80
        print "\r#{COLOR_BOLD}#{COLOR_CYAN}80% completion - You have #{display_time} remaining#{COLOR_RESET}"
      end

      sleep(1)
    end

    puts "\n\n"
  end

  puts "#{COLOR_BOLD}#{COLOR_GREEN}Countdown complete!#{COLOR_RESET}"
end

def run_countdown
  puts "\n#{COLOR_BOLD}#{COLOR_BLUE}Welcome to the Countdown Clock program!#{COLOR_RESET}"
  puts "#{COLOR_BOLD}#{COLOR_RESET}This program helps you manage your time by providing countdowns for different task completion percentages."
  puts "#{COLOR_BOLD}#{COLOR_RESET}You can enter your information below to get started."

  proceed = get_user_input("\n#{COLOR_BOLD}#{COLOR_YELLOW}Do you want to proceed? (Y/N):#{COLOR_RESET}").downcase

  if proceed == 'y'
    dev_name = get_user_input("\nEnter your #{COLOR_BOLD}#{COLOR_RED}dev name#{COLOR_RESET}: ")
    task = get_user_input("Enter the #{COLOR_BOLD}#{COLOR_RED}task#{COLOR_RESET}: ")
    hours = get_hours_input

    clear_terminal

    puts "\nThank you, #{COLOR_BOLD}#{COLOR_RED}#{dev_name}!#{COLOR_RESET} You've entered the following details:"
    puts "\nTask: #{COLOR_BOLD}#{COLOR_CYAN}#{task}#{COLOR_RESET}"
    puts "Time Available: #{COLOR_BOLD}#{COLOR_CYAN}#{hours} #{hours == 1 ? 'hour' : 'hours'}#{COLOR_RESET}"
    puts "Deadline in #{COLOR_BOLD}#{COLOR_CYAN}#{format('%02d:%02d:%02d', hours, 0, 0)}#{COLOR_RESET}"
    puts "\n"

    countdown(hours)
  else
    puts "\n#{COLOR_BOLD}#{COLOR_RED}Exiting the program. Goodbye!#{COLOR_RESET}" 
  end
end

run_countdown
