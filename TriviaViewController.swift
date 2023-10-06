import UIKit

struct TriviaQuestion {
    let category: String
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
    var userAnswerIndex: Int?
}

class TriviaViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var ButtonAnswer1: UIButton!
    @IBOutlet weak var ButtonAnswer2: UIButton!
    @IBOutlet weak var ButtonAnswer3: UIButton!
    @IBOutlet weak var ButtonAnswer4: UIButton!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var relatedImage: UIImageView!
    var currentQuestionIndex = 0
    var userScore = 0
    
    var triviaQuestions: [TriviaQuestion] = [
        TriviaQuestion(
            category: "Music",
            question: "Who is often referred to as the 'King of Pop'?",
            answers: ["a) Elvis Presley", "b) Michael Jackson", "c) Madonna", "d) The Beatles"],
            correctAnswerIndex: 1,
            userAnswerIndex: nil
        ),
        TriviaQuestion(
            category:"History",
            question: "Which ancient civilization is known for building the Great Wall of China?",
            answers: ["a) Roman Empire", "b) Egyptian Empire", "c) Inca Empire", "d) Chinese Empire (Qin Dynasty)"],
            correctAnswerIndex: 3,
            userAnswerIndex: nil
        ),
        TriviaQuestion(
            category: "Sports",
            question: "Which sport is played in the Super Bowl championship game in the United States?",
            answers: ["a) Baseball", "b) Basketball", "c) American Football", "d) Soccer"],
            correctAnswerIndex: 2,
            userAnswerIndex: nil
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentQuestionIndex < triviaQuestions.count {
            displayQuestion()
        } else {
            // End of the game
            showFinalScore() // Display the final score pop-up
        }
    }
    
    func showFinalScore() {
        // Calculate the user's final score here
        let finalScore = calculateFinalScore()
        
        // Create a UIAlertController to display the final score
        let alertController = UIAlertController(title: "Game Over", message: "Your Score: \(finalScore)", preferredStyle: .alert)
        
        // Add an action to dismiss the alert
        let dismissAction = UIAlertAction(title: "OK", style: .default) { (_) in
            // Handle the OK button press (e.g., reset the game)
        }
        alertController.addAction(dismissAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    func calculateFinalScore() -> Int {
        var userScore = 0 // Initialize userScore to zero
            
            for question in triviaQuestions {
                let correctAnswerIndex = question.correctAnswerIndex
                if let userAnswerIndex = question.userAnswerIndex, userAnswerIndex == correctAnswerIndex {
                    // If the user answered this question and their answer is correct, increment the score
                    userScore += 1
                }
            }
            
            return userScore
    }
    
    func displayQuestion() {
        let currentQuestion = triviaQuestions[currentQuestionIndex]
        questionLabel.text = currentQuestion.question
        category.text = currentQuestion.category
        ButtonAnswer1.setTitle(currentQuestion.answers[0], for: .normal)
        ButtonAnswer2.setTitle(currentQuestion.answers[1], for: .normal)
        ButtonAnswer3.setTitle(currentQuestion.answers[2], for: .normal)
        ButtonAnswer4.setTitle(currentQuestion.answers[3], for: .normal)
        
        // Update the question number label
        let questionNumberText = "Question \(currentQuestionIndex + 1)/\(triviaQuestions.count)"
        questionNumber.text = questionNumberText
        relatedImage.image = UIImage(named: currentQuestion.category)
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let currentQuestion = triviaQuestions[currentQuestionIndex]
        let correctAnswerIndex = currentQuestion.correctAnswerIndex
        let selectedAnswerIndex = [ButtonAnswer1, ButtonAnswer2, ButtonAnswer3, ButtonAnswer4].firstIndex(of: sender)
        
        // Debug print statements
        print("Selected Answer Index: \(selectedAnswerIndex)")
        print("Correct Answer Index: \(correctAnswerIndex)")
        
        // Update the userAnswerIndex property for the current question
        triviaQuestions[currentQuestionIndex].userAnswerIndex = selectedAnswerIndex
        
        if selectedAnswerIndex == correctAnswerIndex {
            // Handle correct answer
            userScore += 1 // Increment the user's score for a correct answer
        } else {
            // Handle incorrect answer
        }
        
        currentQuestionIndex += 1
        if currentQuestionIndex < triviaQuestions.count {
            displayQuestion()
        } else {
            // End of the game
            showFinalScore() // Display the final score pop-up
        }
    }
}
