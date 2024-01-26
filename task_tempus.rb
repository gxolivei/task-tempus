def get_user_input(prompt)
  print "\e[1m\e[34m#{prompt}\e[0m"
  gets.chomp
end

def get_hours_input
  loop do
    input = get_user_input("\e[1m\e[32mEnter the amount of time available in hours (minimum is 1 hour):\e[0m")

    if input.to_i.to_s == input && input.to_i.positive?
      return input.to_i
    else
      puts "\e[1m\e[31mInvalid input. Please enter a valid positive number for hours.\e[0m"
    end
  end
end

def clear_terminal
  system('clear') || system('cls')
end

def countdown(hours)
  total_seconds = hours * 60 * 60

  percentages = [20, 60, 80]

  percentages.each do |percentage|
    time_remaining = (total_seconds * percentage / 100).to_i

    puts "\e[1m\e[33mCountdown to #{percentage}% completion of the task:\e[0m"
    puts "\n"

    time_remaining.downto(0) do |remaining_seconds|
      hours_left = remaining_seconds / 3600
      minutes_left = (remaining_seconds % 3600) / 60
      seconds_left = remaining_seconds % 60

      display_time = format('%02d:%02d:%02d', hours_left, minutes_left, seconds_left)

      case percentage
      when 20
        print "\r\e[1m\e[36m20% completion - You have #{display_time} remaining\e[0m"
      when 60
        print "\r\e[1m\e[36m60% completion - You have #{display_time} remaining\e[0m"
      when 80
        print "\r\e[1m\e[36m80% completion - You have #{display_time} remaining\e[0m"
      end

      sleep(1)
    end

    puts "\n\n"
  end

  puts "\e[1m\e[32mCountdown complete!\e[0m"
end

def run_countdown
  puts "\n\e[1m\e[34mWelcome to the Countdown Clock program!\e[0m"
  puts "\e[3mThis program helps you manage your time by providing countdowns for different task completion percentages.\e[0m"
  puts "\e[4mYou can enter your information below to get started.\e[0m"

  proceed = get_user_input("\n\e[1m\e[33mDo you want to proceed? (Y/N):\e[0m").downcase

  if proceed == 'y'
    dev_name = get_user_input("\nEnter your \e[1m\e[35mdev name\e[0m: ")
    task = get_user_input("Enter the \e[1m\e[35mtask\e[0m: ")
    hours = get_hours_input

    clear_terminal

    puts "\nThank you, \e[1m\e[35m#{dev_name}!\e[0m You've entered the following details:"
    puts "\nTask: \e[1m\e[36m#{task}\e[0m"
    puts "Time Available: \e[1m\e[36m#{hours} #{hours == 1 ? 'hour' : 'hours'}\e[0m"
    puts "Deadline in \e[1m\e[36m#{format('%02d:%02d:%02d', hours, 0, 0)}\e[0m"
    puts "\n"

    countdown(hours)
  else
    puts "\n\e[1m\e[31mExiting the program. Goodbye!\e[0m" 
  end
end

run_countdown
