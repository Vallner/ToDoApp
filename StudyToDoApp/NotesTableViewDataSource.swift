//
//  NotesTableViewDataSource.swift
//  StudyToDoApp
//
//  Created by Danila Savitsky on 11.05.25.
//
import UIKit

class NotesTableViewDataSource: NSObject, UITableViewDataSource {
    
    let storage = DataManager()
    var notes: [Note] = DataManager().obtainData()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteCell else {
            let newCell = NoteCell()
            newCell.configure(with: notes[indexPath.row])
            print("new cell")
            return newCell
        }
        print("old cell")
        cell.configure(with: notes[indexPath.row])
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
