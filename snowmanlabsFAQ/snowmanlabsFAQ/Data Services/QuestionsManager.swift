//
//  QuestionsManager.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 22/03/21.
//

import UIKit


//OBS.: This class only deals with local storage at the moment. But has all functions to sync and deal with a remote web service when created, needing litle changes to work properly

class QuestionsManager: NSObject {
    
    //MARK: Local variables
    let questionsDAO : QuestionsDAO = QuestionsDAO()
    let questionsAPI : QuestionsAPI = QuestionsAPI()
    
    //Dispatch group created considering that requesting FAQs or any other service could have multiple async requests. Not currently used since app is using local storage only
    var dispatchGroup: DispatchGroup = DispatchGroup()
    
    
    
    // MARK: Data operations
    
    //Get local and remote FAQ questions, sync then and return synced questions
    func fetchFAQQuestions(completion: @escaping(_ questions: Questions?) -> Void) {
        //Get local and remote questions
        var daoResult = questionsDAO.getFAQQuestions()
        var apiResult: Questions?
        questionsAPI.getFAQQuestions { (receivedQuestions) in
            apiResult = receivedQuestions
        }
        
        //Check for difs
        if let remoteResult = apiResult, let localResult = daoResult {
            let remoteQuestions = remoteResult.questions ?? []
            let localQuestions = localResult.questions ?? []
            if (remoteQuestions.count != localQuestions.count) {
                self.syncQuestions { (success) in
                    if (success) {
                        //now DAO is synced with server questions
                        daoResult = self.questionsDAO.getFAQQuestions()
                        completion(daoResult)
                    } else {
                        //Returning null at the moment, but could try again to fetch questions from server
                        completion(nil)
                    }
                }
            }
        }
    }
    
    
    func saveQuestions(newQuestions: Questions, completion: @escaping(_ updateStatus: Bool) -> Void) {
        var currentUpdateStatus = false
        self.dispatchGroup.enter()
        
        //Save locally and remotely
        currentUpdateStatus = self.questionsDAO.saveQuestions(with: newQuestions)
        self.questionsAPI.saveQuestions(with: newQuestions) { (remoteStatus) in
            self.dispatchGroup.leave()
            currentUpdateStatus = (currentUpdateStatus && remoteStatus)
        }
        
        //After all async calls are done, call completion
        self.dispatchGroup.notify(queue: .main) {
             completion(currentUpdateStatus)
        }
    }
    
    
    func syncQuestions(completion: @escaping(_ success: Bool) -> Void){
        var syncedWithSuccess = false
        
        //Get local questions
        let daoResult = QuestionsDAO().getFAQQuestions()

        //Register async request on dispatchgroup
        self.dispatchGroup.enter()
        
        
        //This logic is considering that server will have each question with a single id.
        // And also considering that server will create an question if ID is not found, or update the correct one if ID exists
        if let localQuestions = daoResult {
            questionsAPI.saveQuestions(with: localQuestions) { (requestStatus) in
                self.dispatchGroup.leave()
                syncedWithSuccess = requestStatus
            }
        }
        
        //After response is received. Just example of dispatch group syncronization in case of multiple web service calls to update.
        // Now it is not that useful and this function could end at the completion from updateRemoteQuestions
        self.dispatchGroup.notify(queue: .main) {
            completion(syncedWithSuccess)
        }
    }
}
