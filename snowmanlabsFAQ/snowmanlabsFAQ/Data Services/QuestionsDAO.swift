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
        
        //Save default questions on local db
        if let defaultQuestionsFromJson = questions {
            self.saveQuestions(with: defaultQuestionsFromJson)
        }
        return questions
    }
    
    /// Considering only saving new questions now, not editing. To edit would need to call fetchQuestions from localDB and filter by ID to identify received object as new question or existing one
    func saveQuestion(with newQuestion: Question) -> Bool {

        //Get question UUID
        //guard let id = UUID(uuidString: newQuestion.id ?? "") else { return false }

        //Generate id for new entity
        let id = UUID()
        
        //Create new entity
        let newEntity = NSEntityDescription.entity(forEntityName: "QuestionDB", in: context)
        let questionDB = NSManagedObject(entity: newEntity!, insertInto: context)
        
        questionDB.setValue(id, forKey: "id")
        questionDB.setValue(newQuestion.title, forKey: "title")
        questionDB.setValue(newQuestion.answer, forKey: "answer")
        questionDB.setValue(newQuestion.color?.rawValue, forKey: "questionColor")
        
        self.updateContext()
        
        return true
    }
    
    func saveQuestions(with newQuestions: Questions) -> Bool {
        var currentStatus = false
        if let questions = newQuestions.questions {
            for question in questions {
                //And operation so will return false if any save failed
                self.saveQuestion(with: question)
            }
        }
        return currentStatus
    }
    
    private func updateContext() {
        do {
            try self.context.save()
        } catch {
            print(error.localizedDescription)
        }
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
        let fetchedQuestions = Questions(questionsFromDB: questionsList)
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
