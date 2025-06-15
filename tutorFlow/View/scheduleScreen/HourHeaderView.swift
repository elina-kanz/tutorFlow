//
//  HourHeaderView.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 14.06.2025.
//

import UIKit

class HourHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "HourHeaderView"
    static let elementKind = "HourHeader"
    
    let hourLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 12)
        element.textColor = .darkGray
        element.textAlignment = .right
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(hourLabel)
        
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            hourLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            hourLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            hourLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4),
        ])
        
        
        backgroundColor = UIColor.systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
