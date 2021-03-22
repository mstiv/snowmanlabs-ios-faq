//
//  QuestionsDAO.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 22/03/21.
//

import UIKit
import CoreData


class QuestionsDAO: NSObject {

    //MARK: Variables
    //var resultManager: NSFetchedResultsController<Question>?
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    //MARK: Database operations. Save, Delete, Get
    func getFAQQuestions() -> Questions? {
        
        //Check local storage database. If nothing is found, use default values from json file
//        var questions = getLocalDatabaseQuestions()
//        guard let _ = questions else {
//
//        }
//
        return nil
    }
    
    func saveQuestions(with newQuestions: Questions) -> Bool {
        return false
    }
    
    
    
    
    //MARK: Data validations and getters
    
    private func getLocalDatabaseQuestions() -> Questions? {
//        let localQuestionsRequest:NSFetchRequest<Question> = DBQuestion.fetchRequest()
//        let orderById = NSSortDescriptor(key: "id", ascending: true)
//        localQuestionsRequest.sortDescriptors = [orderById]
//        
//        resultManager = NSFetchedResultsController(fetchRequest: localQuestionsRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//        
//        do {
//            try resultManager?.performFetch()
//        } catch {
//            print(error.localizedDescription)
//        }
//        
//        guard let questionsList = resultManager?.fetchedObjects else { return nil }
//        
//        //Populate object with fetched response
//        var fetchedQuestions = Questions()
//        fetchedQuestions.lastUpdated = Date.getCurrentDate()
//        fetchedQuestions.questions = 
//        
//        return fetchedQuestions
        return nil
    }
    
    private func getDefaultQuestionsFromJsonFile() -> Questions? {
//        var defaultQuestions :Questions? = nil
        
//        if let path = Bundle.mainBundle().pathForResource("test", ofType: "json")
//        {
//            if let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)
//            {
//                if let jsonResult: NSDictionary = JSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
//                {
//                    if let persons : NSArray = jsonResult["person"] as? NSArray
//                    {
//                        // Do stuff
//                    }
//                }
//             }
//        }
        
        return nil
    }

}


extension Date {
 static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())

    }
}
