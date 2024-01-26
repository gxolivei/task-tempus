require_relative 'user_interaction_module' 

class TaskTempus
  include UserInteraction

  def run_countdown
    clear_terminal
  
    puts "\n#{STYLES[:bold]}#{STYLES[:cyan]}Welcome to Task Tempus#{STYLES[:reset]}"
    puts "\n#{STYLES[:bold]}This program helps you manage your time by providing countdowns for different task completion percentages.#{STYLES[:reset]}"
    puts "#{STYLES[:bold]}To interrupt and exit gracefully press CTRL+C at any time.#{STYLES[:reset]}"
  
    proceed = get_user_input("\n#{STYLES[:bold]}#{STYLES[:yellow]}Do you want to proceed? (Y/N):#{STYLES[:reset]} ").downcase
  
    if proceed == 'y'
  
      clear_terminal
  
      dev_name = get_dev_name
      task = get_task
      hours = get_hours_input
      custom_percentages = get_custom_percentages
  
      clear_terminal
  
      display_user_details(dev_name, task, hours, custom_percentages)
  
      countdown_display(hours * SECONDS_PER_HOUR, custom_percentages)
    else
  
      clear_terminal
  
      puts "\n#{STYLES[:bold]}#{STYLES[:red]}Exiting the program. Goodbye!#{STYLES[:reset]}" 
    end
  end
end