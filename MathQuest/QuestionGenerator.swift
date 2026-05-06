//
//  QuestionGenerator.swift
//  MathQuest
//
//  Created by Adri Ganz on 4/23/26.
//
import Foundation  // Basic library in swift

// We create a struct to use as a namespace
// We never actually create the object
struct QuestionGenerator {
    
    /*
     * Function: Generate
     * Parameters: MathTopic - Enum, Difficulty - Struct
     * Public function — the only entry point the rest of the app uses
     */
    static func generate(topic: MathTopic, difficulty: Difficulty) -> Question {
        switch topic {
        case .addSubtract:
            return makeAddSubtract(difficulty: difficulty)
        case .multiplyDivide:
            return makeMultiplyDivide(difficulty: difficulty)
        case .fractions:
            return makeFraction(difficulty: difficulty)
        case .algebra:
            return makeAlgebra(difficulty: difficulty)
        }
    }
    
    // MARK: - Private Makers
    
    private static func makeAddSubtract(difficulty: Difficulty) -> Question {
        let range = difficulty.number * 10
        let a = Int.random(in: 1...range)
        let b = Int.random(in: 1...range)
        let add = Bool.random()
        
        let prompt = add ? "\(a) + \(b) = ?" : "\(max(a,b)) - \(min(a,b)) = ?"
        let answer = add ? Double(a + b) : Double(abs(a - b))
        
        return Question(
            prompt: prompt,
            answer: answer,
            choices: makeChoices(correct: answer)
        )
    }
    
    private static func makeMultiplyDivide(difficulty: Difficulty) -> Question {
        let range = difficulty.number * 10
        let a = Int.random(in: 1...range)
        let b = Int.random(in: 1...12)
        let multiply = Bool.random()
        
        // This approach doesn't give whole number values
        // let prompt = multiply ? "\(a) * \(b) = ?" : "\(a) / \(b) = ?"
        // let answer = multiply ? Double(a*b) : Double(a/b)
        
        let prompt = multiply ? "\(a) × \(b) = ?" : "\(a * b) ÷ \(b) = ?"
        let answer = multiply ? Double(a * b) : Double(a)
        
        return Question(
            prompt: prompt,
            answer: answer,
            choices: makeChoices(correct: answer)
        )
    }
    
    private static func makeFraction(difficulty: Difficulty) -> Question {
        let denominators = [2, 3, 4, 6, 8, 10]
        let denom = denominators.randomElement()!
        let numer = Int.random(in: 1..<denom)
        let answer = Double(numer) / Double(denom)
        
        let prompt = "\(numer)/\(denom) as a decimal = ?"
        return Question(
            prompt: prompt,
            answer: answer,
            choices: makeChoices(correct: answer, spread: 0.5)
        )
    }
    
    private static func makeAlgebra(difficulty: Difficulty) -> Question {
        let b = Int.random(in: 1...10)
        let answer = Int.random(in: 1...(difficulty.number * 5))
        let total = answer + b
        
        let prompt = "x + \(b) = \(total), x = ?"
        return Question(
            prompt: prompt,
            answer: Double(answer),
            choices: makeChoices(correct: Double(answer))
        )
    }
    
    // MARK: - Choice Builder
    
    private static func makeChoices(correct: Double, spread: Double = 3.0) -> [Double] {
        var choices = Set<Double>([correct])
        
        while choices.count < 4 {
            let offset = Double(Int.random(in: 1...Int(max(spread, 1) * 2)))
            let sign = Bool.random() ? 1.0 : -1.0
            let wrong = (correct + offset * sign * (spread < 1 ? 0.25 : 1)).rounded(toPlaces: 2)
            if wrong > 0 && wrong != correct {
                choices.insert(wrong)
            }
        }
        return choices.shuffled()
    }
    
}

// MARK: - Double Extension

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}
