//
//  DayHeaderView.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 14.06.2025.
//
import UIKit

class DayHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "DayHeaderView"
    static let elementKind = "DayHeader"
    
    let stackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fillEqually
        element.spacing = 2
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let dayLabel: UILabel = {
        let element = UILabel()
        element.font = .boldSystemFont(ofSize: 14)
        element.textColor = .black
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let dateLabel: UILabel = {
        let element = UILabel()
        element.font = .boldSystemFont(ofSize: 14)
        element.textColor = .black
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
        ])
        
        backgroundColor = .systemBackground
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray3.cgColor
    }
}
