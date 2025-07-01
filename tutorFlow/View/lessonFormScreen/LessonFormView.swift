//
//  LessonFormView.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 20.06.2025.
//

import UIKit

class LessonFormView: UIView {
    
    lazy var contentView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.backgroundColor = .systemBackground
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var titleTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter title"
        field.font = .systemFont(ofSize: 16)
        field.textColor = .darkGray
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var dateContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .compact
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var durationPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var studentsContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var searchField: UITextField = {
        let field = UITextField()
        field.placeholder = "Student's surname"
        field.borderStyle = .roundedRect
        field.returnKeyType = .done
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var resultsTableView: UITableView = {
        let table = UITableView()
        table.register(StudentCell.self, forCellReuseIdentifier: StudentCell.reuseIdentifier)
        table.isHidden = true
        table.layer.cornerRadius = 8
        table.clipsToBounds = true
        table.rowHeight = 44
        return table
    }()
    
    lazy var selectedStudentsCollection: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 120, height: 30)
            
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.register(SelectedStudentCell.self, forCellWithReuseIdentifier: "SelectedStudentCell")
            collection.backgroundColor = .clear
            collection.showsHorizontalScrollIndicator = false
            return collection
        }()
    
    lazy var recurrenceContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var recurrenceLabel: UILabel = {
        let label = UILabel()
        label.text = "Repeat:"
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var recurrencePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    
    lazy var notesTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter notes"
        field.font = .systemFont(ofSize: 16)
        field.textColor = .darkGray
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete lesson", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        backgroundColor = .systemBackground
        
        addSubview(contentView)
        
        contentView.layoutMargins = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        contentView.isLayoutMarginsRelativeArrangement = true
        
        contentView.addArrangedSubview(titleTextField)
        
        contentView.addArrangedSubview(dateContainer)
        dateContainer.addArrangedSubview(datePicker)
        dateContainer.addArrangedSubview(durationPicker)
        
        contentView.addArrangedSubview(studentsContainer)
        studentsContainer.addArrangedSubview(searchField)
        studentsContainer.addArrangedSubview(resultsTableView)
        studentsContainer.addArrangedSubview(selectedStudentsCollection)
        
        contentView.addArrangedSubview(recurrenceContainer)
        recurrenceContainer.addArrangedSubview(recurrenceLabel)
        recurrenceContainer.addArrangedSubview(recurrencePicker)
        
        contentView.addArrangedSubview(notesTextField)
        contentView.addArrangedSubview(deleteButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            datePicker.heightAnchor.constraint(equalToConstant: 40),
            durationPicker.heightAnchor.constraint(equalToConstant: 120),
            
            resultsTableView.heightAnchor.constraint(equalToConstant: 200),
            selectedStudentsCollection.heightAnchor.constraint(equalToConstant: 40),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            
            recurrencePicker.heightAnchor.constraint(equalToConstant: 100),
            recurrencePicker.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
        ])
    }
    
    func showSearchResults(_ show: Bool) {
            UIView.animate(withDuration: 0.3) {
                self.resultsTableView.isHidden = !show
            }
        }
}
                        
