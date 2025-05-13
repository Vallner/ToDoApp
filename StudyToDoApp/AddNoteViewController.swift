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
    
    var sectionOfExistingCell:Int?
    
    var priorityOfExistingCell:Priority? = .medium
    
    var noteToEdit: Note?
    
    lazy private var Label:UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "Add Note"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy private  var titleTextLabel:UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "Title:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy  var titleTextField:UITextField = {
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
    
    lazy private var noteTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Note:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy private var PriorityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Choose priority:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy private var Slider: UISlider = {
        var slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 2
        slider.value = 1
        slider.isEnabled = true
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
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
        let stackView = UIStackView(arrangedSubviews: [titleTextLabel, titleTextField, Slider , noteTextLabel, textView])
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
    
    func configure(with note: Note) {
        self.textView.text = note.text
        self.titleTextField.text = note.title
        self.priorityOfExistingCell = note.priority
    }
    
    func checkPriority() -> Int {
        let priorityValue = Int(round(Slider.value))
        switch priorityValue {
        case 0:
            priorityOfExistingCell! = .low
            return 2
        case 1:
            priorityOfExistingCell! = .medium
            return 1
        case 2:
            priorityOfExistingCell! = .high
            return 0
        default:
            priorityOfExistingCell! = .low
            return 2
        }
    }
 
    @objc func handleSaveNote(sender: UIBarButtonItem) {
        
        let sectionNumber = checkPriority()
        //takes delegate, accseses to hisdatasource and adds and configurates note to specifed section by its priority
        delegate?.dataSource.save(note: Note(priority: priorityOfExistingCell!, title: titleTextField.text ?? "", text: textView.text ?? ""), sectionNumber: sectionNumber)
//        delegate?.dataSource.notes.append(Note(title: titleTextField.text ?? "" , text: textView.text ?? "")
//        delegate?.dataSource.storage.saveData((delegate!.dataSource.notes))
            print("Add Note")
        delegate?.notesTableView.reloadData()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handleEditNote(sender: UIBarButtonItem) {
        
        let sectionNumber = checkPriority()
        if sectionOfExistingCell! != sectionNumber {
            delegate?.dataSource.notes[sectionOfExistingCell!].remove(at: numberOfExistingCell!)
        }
        delegate?.dataSource.notes[sectionOfExistingCell!][numberOfExistingCell!] = Note(priority: priorityOfExistingCell!, title: titleTextField.text ?? "", text: textView.text ?? "")
//        delegate?.dataSource.storage.saveData((delegate!.dataSource.notes))
            print("Edit Note")
        delegate?.notesTableView.reloadData()
        navigationController?.popToRootViewController(animated: true)
    }
}
