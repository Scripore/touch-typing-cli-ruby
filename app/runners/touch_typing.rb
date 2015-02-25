class TouchTyping
include TypeModules

  TypeModules.welcome_text

  selection_input = STDIN.getch
  reddit_posts = TypeModules.get_headlines(selection_input)

  loop do 
    number = []
    full_text_array = []
    
    array = reddit_posts 
    number << (array[rand(0..(reddit_posts.size - 1))])
    number = number.flatten
    string =  number[0]
    
    sentence_to_match = string.chars
    user_sentence = string.chars
    user_sentence = user_sentence.map! {|x| x = '#'}
    index = 0

    TypeModules.begin_typing(string, sentence_to_match)

    while sentence_to_match != user_sentence

      user_sentence[index] = (input = STDIN.getch)
      start_time = Time.now.to_i if index == 0

      while user_sentence[index] != sentence_to_match[index]
        user_sentence[index] = (input = STDIN.getch)
        exit if input == "\e" || input == '|'
      end

      index += 1
      TypeModules.refresh_screen
        
      speed = TypeModules.print_speed_char(string, user_sentence, sentence_to_match, start_time, index)
      abort if input == "\e" 

    end

    seconds_it_took = Time.now.to_i - start_time
    TypeModules.refresh_screen

    emoji = TypeModules.get_emoji(speed)

    TypeModules.generate_final_score(seconds_it_took, speed, emoji)
    
    2.times {puts "\n"}
    puts "#{">>>".colorize(:red)} Want to visit the reddit thread? (y/n)"

    Launchy.open(number[1]) if STDIN.getch == 'y'
    TypeModules.refresh_screen
    
  end

end