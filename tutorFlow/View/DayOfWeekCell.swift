//
//  dayOfWeekCell.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 04.06.2025.
//
import UIKit

class DayOfWeekCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "DayOfWeekCellIndentifier"
    
    private lazy var stackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let dayNameLabel: UILabel = {
        let element = UILabel()
        element.textColor = .gray
        element.font = UIFont(name: "", size: 10)
        element.textAlignment = .center
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let dayNumberLabel: UILabel = {
        let element = UILabel()
        element.textColor = .gray
        element.textAlignment = .center
        element.font = UIFont(name: "", size: 20)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        addSubview(stackView)
        stackView.addSubview(dayNameLabel)
        stackView.addSubview(dayNumberLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dayNameLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 4),
            dayNameLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            
            dayNumberLabel.topAnchor.constraint(equalTo: dayNameLabel.bottomAnchor),
            dayNumberLabel.centerXAnchor.constraint(equalTo: dayNameLabel.centerXAnchor),
            dayNumberLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4)
        ])
    }
}
