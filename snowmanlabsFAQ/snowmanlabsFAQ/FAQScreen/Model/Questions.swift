//
//  Questions.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 22/03/21.
//

import UIKit
import CoreData

class Questions: NSObject, Codable {

    var questions: Array<Question>?
    var lastUpdated: String?
    
    init(questionsFromDB: Array<QuestionDB>) {
        self.questions = Array<Question>()
        for questionDB in questionsFromDB {
            //parse data
            let currentQuestion = Question()
            currentQuestion.id = String(describing: questionDB.id)
            currentQuestion.title = questionDB.title
            currentQuestion.answer = questionDB.answer
            currentQuestion.color = QuestionColors(rawValue: questionDB.questionColor ?? ColorConstants().DEFAULT_FAQ_QUESTION_COLOR)
            
            //add to questions list
            self.questions!.append(currentQuestion)
        }
    }
    
    override init () {
        super.init()
    }
}
