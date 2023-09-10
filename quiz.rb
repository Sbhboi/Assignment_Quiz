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

score = 0

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
      questions.each do |question_data|
        puts question_data[:question]
        user_answer = gets.chomp
        if user_answer.downcase == question_data[:answer].downcase
          puts "Correct!"
          score += 10
        else
          puts "Incorrect. The correct answer is: #{question_data[:answer]}"
        end
      end
    else
      puts "Invalid quiz choice. Please try again."
    end
  
    # Option to continue or quit
    puts "Do you want to take another quiz? (yes/no)"
    continue_choice = gets.chomp.downcase
    break if continue_choice == "no"
  end
  
  puts "Thank you for playing #{user_name}!"
  puts "your final score is: #{score} pts."