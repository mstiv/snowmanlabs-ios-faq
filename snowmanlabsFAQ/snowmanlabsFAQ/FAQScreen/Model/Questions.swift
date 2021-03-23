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
    
   init(fromDB: Array<QuestionDB>) {
        
    }
    
    override init () {
        super.init()
    }
}
