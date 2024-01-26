module CountdownHelpers
  include Styling
  include Constants

  def display_countdown(percentage, display_time)
    print "\r#{STYLES[:bold]}#{STYLES[:cyan]}#{percentage}% completion - You have #{display_time} remaining#{STYLES[:reset]}"
  end
  
  def countdown_display(total_seconds, custom_percentages)
    custom_percentages.each do |percentage|
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
end