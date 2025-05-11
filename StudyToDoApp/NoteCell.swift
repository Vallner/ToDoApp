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
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var noteDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupLayout(){
        
        contentView.addSubview(noteTitleLabel)
        contentView.addSubview(noteDescriptionLabel)
        NSLayoutConstraint.activate([
            
            noteTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            noteTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            noteTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            
            noteDescriptionLabel.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: 4),
            noteDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            noteDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            noteDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
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
        
        self.noteDescriptionLabel.text = Note.text
        self.noteTitleLabel.text = Note.title
        setupLayout()
    }
}
