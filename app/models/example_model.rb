module TypeModules

  def self.welcome_text
    self.refresh_screen
    puts <<-TEXT
The headlines will be parsed from r/WritingPrompts. Please select a time period to parse the top 25 threads from. 
Enter in a #{"number".colorize(:blue)} to make your selection:   

1) All time
2) This year
3) This month
4) This week
5) Last 24 hours
  TEXT
  end

  def self.refresh_screen
    100.times {puts "\n"}
  end

  def self.get_emoji(speed)
    if speed <= 40 
      emoji = "(╥﹏╥) Shameful!"
    elsif speed.between?(40, 60) 
      emoji = "Meh..."
    else
      emoji = "(σ・・)σ  You da man!"
    end   
    return emoji
  end

  def self.interval_selected(selection_input)
    interval = "all" if selection_input == "1"
    interval = "year" if selection_input == "2"
    interval = "month" if selection_input == "3"
    interval = "week" if selection_input == "4"
    interval = "day" if selection_input == "5"
  end

  def self.generate_final_score(seconds_it_took, speed, emoji)
    puts <<-TEXT
  __________________________________________________________________________________
         
          It took you #{seconds_it_took.to_s.colorize(:red)} seconds.  
          Your WPM (words per minute) is #{speed.to_s.colorize(:red)}
          #{emoji.colorize(:blue)}  
  __________________________________________________________________________________
  TEXT
  end

  def self.get_headlines(selection_input)
    puts "\n\n\n"
    interval = TypeModules.interval_selected(selection_input)
    reddit = RedditReader.new("http://www.reddit.com/r/writingprompts/top/.json?sort=top&t=#{interval}") 
    reddit.read!
    reddit.generate_html('./testingreddit.txt')
    return reddit.posts   
  end

  def self.begin_typing(string, sentence_to_match)
    puts "Begin when ready."
    puts "Press ESC twice to exit program.\n\n"
    puts "#{">>>".colorize(:red)} Type this sentence:\n"
    puts string.colorize(:red)
    puts "\nType in the first letter: '#{sentence_to_match[0].colorize(:red)}'" unless sentence_to_match[0] == nil
  end  

  def self.print_speed_char(string, user_sentence, sentence_to_match, start_time, index)
    puts string.colorize(:red)
    puts "\n"
    puts user_sentence.join 
    puts "\n-----------------------------------"
    puts "Type in '#{sentence_to_match[index].colorize(:red)}'" unless sentence_to_match[index] == nil
    speed = (((sentence_to_match[0..index].size/5.1)/(Time.now.to_i - start_time)) * 60.0).round(1)
    puts "Current speed: #{speed.to_s.colorize(:red)}"
    return speed
  end

end




