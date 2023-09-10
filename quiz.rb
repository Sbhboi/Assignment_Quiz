require 'timeout'

# Quiz data structure
quizzes = {
  science: [
    { question: "What is the largest planet in our solar system?", answer: "Jupiter" },
    { question: "What is the atomic symbol for gold?", answer: "Au" },
    { question: "What is the process by which plants convert sunlight into energy?", answer: "Photosynthesis" }
  ],
  history: [
    { question: "Who was the first President of the United States?", answer: "George Washington" },
    { question: "In what year did World War II end?", answer: "1945" },
    { question: "What ancient civilization built the Great Wall of China?", answer: "The Chinese civilization" }
  ],
  sports: [
    { question: "Which sport uses a shuttlecock?", answer: "Badminton" },
    { question: "Who holds the record for the most home runs in MLB history?", answer: "Barry Bonds" },
    { question: "In what country were the first Olympic Games held?", answer: "Greece" }
  ]
}

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
        
        begin
            Timeout.timeout(10) do # Adjust the time limit as needed
              start_time = Time.now
              user_answer = gets.chomp.downcase
              end_time = Time.now
    
              time_taken = end_time - start_time
              time_penalty = (time_taken * 2).to_i # Adjust the penalty calculation as needed
    
              if user_answer == question_data[:answer].downcase
                score += 10 - time_penalty
                puts "Correct!"
              else
                puts "Incorrect. The correct answer is: #{question_data[:answer]}"
              end
            end
          rescue Timeout::Error
            puts "Time's up! You didn't answer in time."
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
  
  puts "Thank you for playing #{user_name}!"
  puts "your final score is: #{total_score} pts."