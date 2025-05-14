//
//  ViewController.swift
//  StudyToDoApp
//
//  Created by Danila Savitsky on 11.05.25.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {
    
    let  dataSource = NotesTableViewDataSource()
    
    let notesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(NoteCell.self, forCellReuseIdentifier: "NoteCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 80
        return tableView
    }()
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        notesTableView.dataSource = dataSource
        notesTableView.delegate = self
        dataSource.loadData()
        setupTopBarButtonItem()
        setupLayout()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.dataSource.notes[indexPath.section].remove(at: indexPath.row)
            print("newData:",self.dataSource.notes)
            self.notesTableView.deleteRows(at: [indexPath], with: .automatic)
            self.dataSource.saveData()
        }
        return UISwipeActionsConfiguration(actions: [swipeAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let addViewController = AddNoteViewController()
        addViewController.configure(with: dataSource.notes[indexPath.section][indexPath.row])
        addViewController.isEditingExistingCell = true
        addViewController.numberOfExistingCell = indexPath.row
        addViewController.sectionOfExistingCell = indexPath.section
        addViewController.delegate = self
        navigationController?.pushViewController(addViewController, animated: true)
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
    
    func setupTopBarButtonItem() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddNote))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func handleAddNote(sender: UIBarButtonItem) {
        let addViewController = AddNoteViewController()
        addViewController.delegate = self
        navigationController?.pushViewController(addViewController, animated: true)
        }
}

