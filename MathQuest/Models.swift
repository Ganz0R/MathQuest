//
//  Models.swift
//  MathQuest
//
//  Created by Adri Ganz on 4/15/26.
//

//Enum: MathTopic
//String type.
//CaseIterable loop over cases. Good for menus
enum MathTopic : String, CaseIterable{
    case addSubtract    = "Add/Subtract"
    case multiplyDivide = "Multiply/Divide"
    case fractions      = "Fractions"
    case Algebra        = "Algebra"
}

//Struct: Question
//Where to store the type of question
struct Question {
    let propmt: String          //Immutable Variable String
    let answer: Double          //Immutable variable double
    let choices: [Double]       //Immutable variable array of double
}
//Struct: Difficulty
//Scale difficulty
struct Difficulty{
    let number: Int             //Level type
    let timeLimit: Int          //Time left on the question
    let questionCount: Int      //How many questions per round
}
