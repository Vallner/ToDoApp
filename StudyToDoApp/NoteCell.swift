//
//  NoteCell.swift
//  StudyToDoApp
//
//  Created by Danila Savitsky on 11.05.25.
//

import UIKit

class NoteCell: UITableViewCell {
    
    lazy var noteTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var noteDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var noteDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupLayout(){
        contentView.addSubview(noteDateLabel)
        contentView.addSubview(noteTitleLabel)
        contentView.addSubview(noteDescriptionLabel)
        NSLayoutConstraint.activate([
            
            noteTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            noteTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            noteTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            
            noteDescriptionLabel.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: 4),
            noteDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            noteDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            noteDateLabel.topAnchor.constraint(equalTo: noteDescriptionLabel.bottomAnchor, constant: 8),
            noteDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            noteDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
    }
}
extension NoteCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension NoteCell{
    func  configure(with Note: Note){
        let currentDate = Note.addedDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateText = dateFormatter.string(from: currentDate )
        self.noteDateLabel.text = dateText
//        print (dateFormatter.string(from: currentDATE))
        self.noteDescriptionLabel.text = Note.text
        self.noteTitleLabel.text = Note.title
        setupLayout()
    
        var backgroundConfiguration = self.defaultBackgroundConfiguration()
        backgroundConfiguration.backgroundInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        backgroundConfiguration.cornerRadius = 10
        backgroundConfiguration.backgroundColor = {
            switch Note.priority {
                           case "High priority":
                           return .systemRed
                       case "Medium priority":
                           return .systemYellow
                       default:
                           return .systemGreen
                       }
                   }()
        self.backgroundConfiguration = backgroundConfiguration
        
//        self.backgroundColor = {
//
    }
}
