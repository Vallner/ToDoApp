//
//  ViewController.swift
//  StudyToDoApp
//
//  Created by Danila Savitsky on 11.05.25.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {
    
    let notesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(NoteCell.self, forCellReuseIdentifier: "NoteCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 80
        return tableView
    }()
    
    let  dataSource = NotesTableViewDataSource()
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddNote))
        navigationItem.rightBarButtonItem = addButton
        
        notesTableView.dataSource = dataSource
        notesTableView.delegate = self
        
        setupLayout()
    }
    
    func setupLayout() {
            
        view.addSubview(notesTableView)
            
        NSLayoutConstraint.activate([
            notesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
    }
    
    @objc func handleAddNote(sender: UIBarButtonItem) {
        let addViewController = AddNoteViewController()
        addViewController.delegate = self
        navigationController?.pushViewController(addViewController, animated: true)
//            self.dataSource.notes.append(Note(title: "New Note", text: "Hello, world!"))
//            self.dataSource.storage.saveData((self.dataSource.notes))
//            print("Add Note")
//            self.notesTableView.reloadData()
        }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
     
            self.dataSource.notes.remove(at: indexPath.row)
            self.dataSource.storage.saveData((self.dataSource.notes))
            self.notesTableView.deleteRows(at: [indexPath], with: .automatic)
//            self.notesTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [swipeAction])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let addViewController = AddNoteViewController()
        addViewController.titleTextField.text = self.dataSource.notes[indexPath.row].title
        addViewController.textView.text = self.dataSource.notes[indexPath.row].text
        addViewController.isEditingExistingCell = true
        addViewController.numberOfExistingCell = indexPath.row
        addViewController.delegate = self
        navigationController?.pushViewController(addViewController, animated: true)
    }
}

