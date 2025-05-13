//
//  DataManager.swift
//  StudyToDoApp
//
//  Created by Danila Savitsky on 11.05.25.
//

import Foundation

enum Status:Codable {
    case active
    case completed
}
enum Priority:Codable {
    case low
    case medium
    case high
}
struct Note:Codable{
   
//    var status: Status
    var priority: Priority
    var title: String
    var text: String

}

class DataManager {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    private let storage = UserDefaults.standard
    
    func obtainData() -> [Priority:[Note]] {
        do{
            let notes =  try self.decoder.decode([Priority:[Note]].self, from: storage.data(forKey: "notes") ?? Data())
            return notes
        }
         catch {
            print("Error")
        }
        return [:]
    }
    
    func saveData(_ notes: [Priority:[Note]]) {
        do{
            let data = try self.encoder.encode(notes)
            deleteAllData()
            storage.set(data, forKey: "notes")
        }
        catch {
            print("Error")
        }
    }
    func deleteAllData() {
        storage.removeObject(forKey: "notes")
    }
}
