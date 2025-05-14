//
//  DataManager.swift
//  StudyToDoApp
//
//  Created by Danila Savitsky on 11.05.25.
//

import Foundation

struct Note:Codable{
   
//    var status: Status
    var priority: String
    var title: String
    var text: String

}

class DataManager {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    private let storage = UserDefaults.standard
    
    func obtainData() -> [String:[Note]] {
        do{
            let notes =  try self.decoder.decode([String:[Note]].self, from: storage.data(forKey: "notes") ?? Data())
            return notes
        }
         catch {
            print("Error")
        }
        return [:]
    }
    
    func saveData(_ notes: [String:[Note]]) {
        do{
            let data = try self.encoder.encode(notes)
            storage.set(data, forKey: "notes")
        }
        catch {
            print("Error")
        }
    }
}
