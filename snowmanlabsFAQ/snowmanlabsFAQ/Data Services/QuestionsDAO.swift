//
//  QuestionsDAO.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 22/03/21.
//

import UIKit
import CoreData


class QuestionsDAO: NSObject {
    
    let DEFAULT_FAQ_JSON: String = "FAQQuestions"

    //MARK: Variables
    var resultManager: NSFetchedResultsController<QuestionDB>?
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    //MARK: Database operations. Save, Delete, Get
    func getFAQQuestions() -> Questions? {
        
        //Check local storage database. If nothing is found, use default values from json file
        var questions = getLocalDatabaseQuestions()
        if let localQuestions = questions {
            return localQuestions
        }
        //Nothing found on local database, use default file
        questions = self.getDefaultQuestionsFromJsonFile()
        return questions
    }
    
    func saveQuestions(with newQuestions: Questions) -> Bool {
        return false
    }
    
    
    
    
    //MARK: Data validations and getters
    
    private func getLocalDatabaseQuestions() -> Questions? {
        let localQuestionsRequest:NSFetchRequest<QuestionDB> = QuestionDB.fetchRequest()
        let orderById = NSSortDescriptor(key: "id", ascending: true)
        localQuestionsRequest.sortDescriptors = [orderById]
        
        resultManager = NSFetchedResultsController(fetchRequest: localQuestionsRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try resultManager?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        guard let questionsList = resultManager?.fetchedObjects else { return nil }
        
        //Populate object with fetched response
        if(questionsList.count == 0 ) {
            return nil
        }
        let fetchedQuestions = Questions(fromDB: questionsList)
        return fetchedQuestions
    }
    
    /// Read local JSON file that has default questions, in case API fails to populate data
    private func getDefaultQuestionsFromJsonFile() -> Questions? {
        var defaultQuestions :Questions? = nil
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        if let path = Bundle.main.path(forResource: DEFAULT_FAQ_JSON, ofType: "json")
        {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let questionsData: Questions = try decoder.decode(Questions.self, from: jsonData)
                    defaultQuestions = questionsData
            } catch {
                // handle error
                print(error.localizedDescription)
            }
        }
        return defaultQuestions
    }

}


extension Date {
 static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())

    }
}
