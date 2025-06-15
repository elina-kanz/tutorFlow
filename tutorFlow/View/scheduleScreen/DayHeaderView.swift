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
        
        addSubview(dayLabel)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
           // dayLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: dayLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: dayLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4),
        ])
        
        backgroundColor = .clear
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
