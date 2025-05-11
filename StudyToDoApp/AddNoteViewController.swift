 //  AddNoteViewController.swift
//  StudyToDoApp
//
//  Created by Danila Savitsky on 11.05.25.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    weak var delegate:ViewController?
    
    var isEditingExistingCell:Bool?
    
    var numberOfExistingCell:Int?
    
    lazy var Label:UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "Add Note"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var titleTextLabel:UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "Title:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy var titleTextField:UITextField = {
        var titleTextField = UITextField()
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        titleTextField.textColor = .black
        titleTextField.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        titleTextField.layer.cornerRadius = 8
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        return titleTextField
    }()
    
    lazy  var textView: UITextView = {
        var textView = UITextView()
        textView.textColor = .black
        textView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        textView.layer.cornerRadius = 8
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.layer.cornerRadius = 8
//        textView.text = "Note"
        textView.font = .systemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var noteTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Note:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        if isEditingExistingCell ?? false {
            
            let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditNote))
            navigationItem.rightBarButtonItem = editButton
        } else {
            let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveNote))
            navigationItem.rightBarButtonItem = addButton
        }
        
        

        setupLayout()
        
        // Do any additional setup after loading the view.
    }
    
    func setupLayout() {
        view.addSubview(Label)
//        view.addSubview(titleTextField)
//        view.addSubview(textView)
        let stackView = UIStackView(arrangedSubviews: [titleTextLabel, titleTextField, noteTextLabel, textView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([

            Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            Label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: Label.bottomAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            ])
    }
 
    @objc func handleSaveNote(sender: UIBarButtonItem) {
        
        delegate?.dataSource.notes.append(Note(title: titleTextField.text ?? "" , text: textView.text ?? ""))
        delegate?.dataSource.storage.saveData((delegate!.dataSource.notes))
            print("Add Note")
        delegate?.notesTableView.reloadData()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handleEditNote(sender: UIBarButtonItem) {
        
        delegate?.dataSource.notes[numberOfExistingCell!] = Note(title: titleTextField.text ?? "", text: textView.text ?? "")
        delegate?.dataSource.storage.saveData((delegate!.dataSource.notes))
            print("Edit Note")
        delegate?.notesTableView.reloadData()
        navigationController?.popToRootViewController(animated: true)
    }
}
