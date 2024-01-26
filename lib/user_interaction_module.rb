module UserInteraction
  include Styling
  include InputHelpers
  include CountdownHelpers
  include Constants

  INTERRUPTED 

  Signal.trap('INT') do
    puts "\n#{STYLES[:bold]}#{STYLES[:red]}Program interrupted. Exiting gracefully.#{STYLES[:reset]}"
    INTERRUPTED = true
    exit(0)
  end

  def get_dev_name
    get_non_empty_input("\n#{STYLES[:bold]}#{STYLES[:cyan]}Enter your dev name:#{STYLES[:reset]} ")
  end

  def get_task
    get_non_empty_input("\n#{STYLES[:bold]}#{STYLES[:cyan]}Enter the task:#{STYLES[:reset]} ")
  end

  def get_custom_percentages
    input = get_user_input("\n#{STYLES[:bold]}#{STYLES[:cyan]}Enter the percentages (comma-separated, e.g., 10,40,50,90):#{STYLES[:reset]} ")
    input.split(',').map(&:to_i)
  end

  def get_hours_input
    get_positive_integer_input("\n#{STYLES[:bold]}#{STYLES[:cyan]}Enter the amount of time available in hours (minimum is 1 hour):#{STYLES[:reset]} ")
  end

  def clear_terminal
    system(CLEAR_COMMAND)
  end

  def display_user_details(dev_name, task, hours, custom_percentages)
    puts "\nThank you, #{STYLES[:bold]}#{STYLES[:cyan]}#{dev_name}!#{STYLES[:reset]} You've entered the following details:"
    puts "\nTask: #{STYLES[:bold]}#{STYLES[:cyan]}#{task}#{STYLES[:reset]}"
    puts "Time Available: #{STYLES[:bold]}#{STYLES[:cyan]}#{hours} #{hours == 1 ? 'hour' : 'hours'}#{STYLES[:reset]}"
    puts "Deadline in #{STYLES[:bold]}#{STYLES[:cyan]}#{format('%02d:%02d:%02d', hours, 0, 0)}#{STYLES[:reset]}"
    puts "Percentages tracked: #{STYLES[:bold]}#{STYLES[:cyan]}#{custom_percentages.map { |percentage| "#{percentage}%" }.join(', ')}#{STYLES[:reset]}"
    puts "\n"
  end
end