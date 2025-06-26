//
//  LessonFormView.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 20.06.2025.
//

import UIKit

class LessonFormView: UIView {
    
    lazy var contentView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.backgroundColor = .systemBackground
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var titleTextField: UITextField = {
        let element = UITextField()
        element.placeholder = "Enter title"
        element.font = .systemFont(ofSize: 16)
        element.textColor = .darkGray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var dateLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 12)
        element.textColor = .black
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var datePickerContainer: UIView = {
        let element = UIView()
        element.backgroundColor = .secondarySystemBackground
        element.layer.cornerRadius = 10
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var datePicker: UIDatePicker = {
        let element = UIDatePicker()
        element.datePickerMode = .dateAndTime
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var durationPicker: UIPickerView = {
        let element = UIPickerView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var studentsContainer: UIView = {
        let element = UIView()
        element.backgroundColor = .secondarySystemBackground
        element.layer.cornerRadius = 10
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var studentsTableView: UITableView = {
        let element = UITableView()
        element.register(UITableViewCell.self, forCellReuseIdentifier: StudentCell.reuseIdentifier)
        element.layer.cornerRadius = 10
        element.clipsToBounds = true
        element.allowsMultipleSelection = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var deleteButton: UIButton = {
        let element = UIButton()
        element.setTitle("Delete lesson", for: .normal)
        element.setTitleColor(.red, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16)
        element.layer.borderColor = UIColor.red.cgColor
        element.layer.borderWidth = 1
        element.layer.cornerRadius = 8
        element.isHidden = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    init () {
        super.init(frame: .zero)
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        
        self.backgroundColor = .systemBackground
        
        addSubview(contentView)
        
        contentView.addArrangedSubview(titleTextField)
        contentView.addArrangedSubview(dateLabel)
        contentView.addArrangedSubview(datePickerContainer)
        
        contentView.layoutMargins = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        contentView.isLayoutMarginsRelativeArrangement = true
        
        datePickerContainer.addSubview(datePicker)
        datePickerContainer.addSubview(durationPicker)
        
        contentView.addArrangedSubview(studentsContainer)

        studentsContainer.addSubview(studentsTableView)
        
        contentView.addArrangedSubview(deleteButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 44),
            datePickerContainer.heightAnchor.constraint(equalToConstant: 200),
            
            datePicker.topAnchor.constraint(equalTo: datePickerContainer.topAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: datePickerContainer.leadingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: datePickerContainer.trailingAnchor, constant: -8),
            datePicker.heightAnchor.constraint(equalToConstant: 40),
            
            durationPicker.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 2),
            durationPicker.leadingAnchor.constraint(equalTo: datePickerContainer.leadingAnchor),
            durationPicker.trailingAnchor.constraint(equalTo: datePickerContainer.trailingAnchor),
            durationPicker.bottomAnchor.constraint(equalTo: datePickerContainer.bottomAnchor),
            
            studentsContainer.topAnchor.constraint(equalTo: datePickerContainer.bottomAnchor, constant: 4),
            studentsContainer.heightAnchor.constraint(equalToConstant: 200),
            
            studentsTableView.topAnchor.constraint(equalTo: studentsContainer.topAnchor, constant: 8),
            studentsTableView.leadingAnchor.constraint(equalTo: studentsContainer.leadingAnchor, constant: 8),
            studentsTableView.trailingAnchor.constraint(equalTo: studentsContainer.trailingAnchor, constant: -8),
            studentsTableView.bottomAnchor.constraint(equalTo: studentsContainer.bottomAnchor, constant: -8),
                    
            deleteButton.topAnchor.constraint(equalTo: studentsContainer.bottomAnchor, constant: 2),
            
            deleteButton.topAnchor.constraint(equalTo: datePickerContainer.bottomAnchor, constant: 2),
            deleteButton.centerXAnchor.constraint(equalTo: datePickerContainer.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
}
                        
