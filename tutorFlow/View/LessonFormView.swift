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
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var datePicker = UIDatePicker()
    lazy var durationPicker = UIPickerView()
    
    init () {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        
        addSubview(contentView)
        
        contentView.addArrangedSubview(titleTextField)
        contentView.addArrangedSubview(dateLabel)
        contentView.addArrangedSubview(datePickerContainer)
        
        contentView.layoutMargins = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        contentView.isLayoutMarginsRelativeArrangement = true
        
        datePickerContainer.addSubview(datePicker)
        datePickerContainer.addSubview(durationPicker)
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
            datePicker.bottomAnchor.constraint(equalTo: datePickerContainer.bottomAnchor, constant: -8),
            
        ])
    }
}
                        
