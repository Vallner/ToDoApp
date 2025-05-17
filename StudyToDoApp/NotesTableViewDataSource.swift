//
//  NotesTableViewDataSource.swift
//  StudyToDoApp
//
//  Created by Danila Savitsky on 11.05.25.
//
import UIKit

class NotesTableViewDataSource: NSObject, UITableViewDataSource {
   
    let storage = DataManager()
    var priorites: [String] = ["High priority", "Medium priority", "Low priority"]
    var notes: [[Note]] = []
    
//    func save(note: Note, sectionNumber: Int) {
//        notes = notesData
//        notes[sectionNumber].append(note)
//        notesData = notes
//    }
    func loadData() {
        var loadedNotes:[[Note]] = []
        for priority in priorites {
            loadedNotes.append(storage.obtainData()[priority] ?? [])
        }
        print(loadedNotes)
        notes = loadedNotes
    }
    
    func saveData() {
        var newData: [String: [Note]] = [:]
        var priority:String = ""
        var iteration:Int = 0
        for row in notes {
            priority = priorites[iteration]
            iteration += 1
            print(priority)
            print(row)
            newData[priority] = row
        }
        storage.saveData(newData)
        }
//        notes = priorites.map { priority in
//            storage.obtainData()[priority]!
//            
//        }
    func numberOfSections(in tableView: UITableView) -> Int {
        print(notes.count)
        return notes.count 
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        priorites[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("notes in ",section ,notes[section].count)
        return notes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteCell else {
            let newCell = NoteCell()
            newCell.configure(with: notes[indexPath.section][indexPath.row])
            print("new cell")
            return newCell
        }
        print("old cell")
        cell.configure(with: notes[indexPath.section][indexPath.row])
        return cell
    }
   
//    func configureCell(_ cell: inout UITableViewCell, forRowAt indexPath: IndexPath) {
//        var newCellConfiguration = cell.defaultContentConfiguration()
//        newCellConfiguration.text = notes[indexPath.row].title
//        newCellConfiguration.secondaryText = notes[indexPath.row].text
//        cell.contentConfiguration = newCellConfiguration
//        
//    }
    
}
