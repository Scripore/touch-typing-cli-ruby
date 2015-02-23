class TouchTyping

  100.times {puts "\n"}

  puts <<-TEXT
The headlines will be parsed from r/WritingPrompts. Please select a time period to parse the top 25 threads from. 
Enter in a #{"number".colorize(:blue)} to select the time period:   

1) All time
2) This year
3) This month
4) This week
5) Last 24 hours
  TEXT

  # make it default to the all time if no input is given in 3 seconds.

  selection_input = STDIN.getch
  puts "\n\n\n"


  interval = "all" if selection_input == "1"
  interval = "year" if selection_input == "2"
  interval = "month" if selection_input == "3"
  interval = "week" if selection_input == "4"
  interval = "day" if selection_input == "5"


  reddit = RedditReader.new("http://www.reddit.com/r/writingprompts/top/.json?sort=top&t=#{interval}") #interpolating subreddit in url string.
  reddit.read!
  reddit.generate_html('./testingreddit.txt')
  reddit_posts = reddit.posts


  loop do 
    number = []
    full_text_array = []

  array = reddit_posts # reassigns array to reddit posts.
  number << (array[rand(0..(reddit_posts.size))])
  string =  number.join(' ')
  sentence_to_match = string.chars
  user_sentence = string.chars
  user_sentence = user_sentence.map! {|x| x = '#'}

  puts "Begin when ready."

  index = 0

  puts "Press ESC twice to exit program.\n\n"

  puts "#{">>>".colorize(:red)} Type this sentence:\n"
  puts string
  puts "\nType in the first letter: '#{sentence_to_match[0].colorize(:red)}'" unless sentence_to_match[0] == nil

  while sentence_to_match != user_sentence

    user_sentence[index] = (input = STDIN.getch)
    if index == 0
      start_time = Time.now.to_i
    end

    while user_sentence[index] != sentence_to_match[index]
      user_sentence[index] = (input = STDIN.getch)
      exit if input == "\e" || input == '|'
    end

    index += 1
    100.times {puts "\n"}
      
    puts string
    puts "\n"
    puts user_sentence.join 
    puts "\n-----------------------------------"
    puts "Type in '#{sentence_to_match[index].colorize(:red)}'" unless sentence_to_match[index] == nil
    speed = (((sentence_to_match[0..index].size/5.1)/(Time.now.to_i - start_time)) * 60.0).round(1)
    puts "Current speed: #{speed.to_s.colorize(:red)}"

    abort if input == "\e" 

  end

  seconds_it_took = Time.now.to_i - start_time
  100.times {puts "\n"}
  puts <<-TEXT
  __________________________________________________________________________________
         
          It took you #{seconds_it_took.to_s.colorize(:red)} seconds.  
          Your WPM (words per minute) is #{speed.to_s.colorize(:red)}
          #{reddit.url.colorize(:blue)}  #need to fix this. direct it to post url instead. 
  __________________________________________________________________________________
  TEXT
  2.times {puts "\n"}
  puts "#{">>>".colorize(:red)} Want to see the reddit thread? (y/n)"
  if STDIN.getch == 'y'
    Launchy.open( "http://www.ruby-lang.org" )
  end

  100.times {puts "\n"}

  end

end