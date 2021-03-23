//
//  QuestionsAPI.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 22/03/21.
//

import UIKit

class QuestionsAPI: NSObject {

    //Used to get and sync questions from FAQ web service. Not implemented yet
    
    func getFAQQuestions(completion: @escaping(_ questions: Questions?) -> Void) {
        //Alamofire request call to FAQ web service
        
        //Empty return while not implemented
        completion(nil)
    }
    
    func saveQuestions(with newQuestions: Questions, completion: @escaping(_ success: Bool) -> Void) {
        
        //Parse Questions to JSON, they are codable
        
        //Send questions to web service put/post request
        completion(true)
    }
    
    func saveQuestion(with newQuestions: Question, completion: @escaping(_ success: Bool) -> Void) {
        
        //Parse Questions to JSON, they are codable
        
        //Send questions to web service put/post request
        completion(true)
    }
    
}
