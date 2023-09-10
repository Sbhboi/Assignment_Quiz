require 'timeout'

# Quiz data structure
quizzes = {
  science: [
    { question: "What is the largest planet in our solar system?", options: ["1) Earth", "2) Mars", "3) Jupiter", "4) Venus"], answer: 3 },
    { question: "What is the atomic symbol for gold?", options: ["1) Ag", "2) Au", "3) Fe", "4) Hg"], answer: 2 },
    { question: "What is the process by which plants convert sunlight into energy?", options: ["1) Photosynthesis", "2) Respiration", "3) Transpiration", "4) Digestion"], answer: 1 }
  ],
  history: [
    { question: "Who was the first President of the United States?", options: ["1) Abraham Lincoln", "2) George Washington", "3) Thomas Jefferson", "4) John Adams"], answer: 2 },
    { question: "In what year did World War II end?", options: ["1) 1939", "2) 1941", "3) 1945", "4) 1950"], answer: 3 },
    { question: "What ancient civilization built the Great Wall of China?", options: ["1) Egyptian civilization", "2) Roman civilization", "3) Chinese civilization", "4) Greek civilization"], answer: 3 }
  ],
  sports: [
    { question: "Which sport uses a shuttlecock?", options: ["1) Tennis", "2) Badminton", "3) Golf", "4) Cricket"], answer: 2 },
    { question: "Who holds the record for the most home runs in MLB history?", options: ["1) Babe Ruth", "2) Hank Aaron", "3) Barry Bonds", "4) Alex Rodriguez"], answer: 3 },
    { question: "In what country were the first Olympic Games held?", options: ["1) Greece", "2) Rome", "3) Egypt", "4) China"], answer: 1 }
  ]
}

custom_quizzes = {}

puts "Welcome to the Quiz Game!"
print "Enter your name:"
user_name = gets.chomp.capitalize
puts "Fancy to play some quiz, #{user_name} ?"

total_score = 0

loop do
    # Welcome message and quiz selection
    puts "Please select a quiz:"
    quizzes.each_with_index do |(quiz, _), index|
      puts "#{index + 1}. #{quiz.capitalize} Quiz"
    end
    quiz_choice = gets.chomp.to_i
  
    # Validating quiz choice
    if quiz_choice.between?(1, quizzes.length)
      selected_quiz = quizzes.keys[quiz_choice - 1]
      puts "You have selected the #{selected_quiz.capitalize} Quiz."
  
      # Accessing quiz questions
      questions = quizzes[selected_quiz]
  
      # Quiz loop
      score = 0
      questions.each do |question_data|
        puts question_data[:question]
        puts "Options:"
        question_data[:options].each { |option| puts option }

        user_answer = nil
        time_penalty = 0
        
        begin
            Timeout.timeout(10) do # Adjust the time limit as needed
              start_time = Time.now
              user_answer = gets.chomp.to_i
              end_time = Time.now
              time_taken = end_time - start_time
              time_penalty = (time_taken * 2).to_i # Adjust the penalty calculation as needed
            end
        rescue Timeout::Error
          puts "Time's up! You didn't answer in time."
        end

          if user_answer == question_data[:answer]
            score += 10 - time_penalty
            puts "Correct!"
          else
            puts "Incorrect. The correct answer is: #{question_data[:answer]}"
          end 
        end

      total_score = total_score + score
      puts "Nice job ! Your score is: #{score} pts."
      puts "Total score: #{total_score} pts."
    else
      puts "Invalid quiz choice. Please try again."
    end
  
    # Option to continue or quit
    puts "Do you want to take another quiz? (yes/no)"
    continue_choice = gets.chomp.downcase
    break if continue_choice == "no"
  end
  
  File.open("highscore.txt", "a") do |file|
    file.puts "#{user_name}: #{total_score}"
  end

  puts "Thank you for playing #{user_name}!"
  puts "your final score is: #{total_score} pts."
  puts "Hi-Score"
  File.readlines("highscore.txt").each do |line|
    puts line
  end