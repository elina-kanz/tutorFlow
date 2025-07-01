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
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(hourLabel)
        
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: topAnchor),
            hourLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            hourLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            hourLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4),
        ])
        
        backgroundColor = .systemBackground
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray3.cgColor
    }
}
