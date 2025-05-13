//
//  NotesTableViewDataSource.swift
//  StudyToDoApp
//
//  Created by Danila Savitsky on 11.05.25.
//
import UIKit

class NotesTableViewDataSource: NSObject, UITableViewDataSource {
   
    let storage = DataManager()
    var notes:[[Note]] = []
    var notesData: [[Note]]{
        get {
          var notesArray: [[Note]] = []
          let notesData =  DataManager().obtainData()
            for priority in notesData.keys {
                notesArray.append(Array(notesData[priority] ?? []))
            }
            return notesArray
        }
        set {
            var notesData: [Priority: [Note]] = [:]
            for section in newValue {
                for note in section {
                    notesData[note.priority]?.append(note)
                }
            }
            storage.saveData(notesData)
        }
    }
    func save(note: Note, sectionNumber: Int) {
        notes = notesData
        notes[sectionNumber].append(note)
        notesData = notes
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesData[section].count
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
    func tableViewNumberOfSections(in tableView: UITableView) -> Int {
        return notes.count
    }
//    func configureCell(_ cell: inout UITableViewCell, forRowAt indexPath: IndexPath) {
//        var newCellConfiguration = cell.defaultContentConfiguration()
//        newCellConfiguration.text = notes[indexPath.row].title
//        newCellConfiguration.secondaryText = notes[indexPath.row].text
//        cell.contentConfiguration = newCellConfiguration
//        
//    }
    
}
