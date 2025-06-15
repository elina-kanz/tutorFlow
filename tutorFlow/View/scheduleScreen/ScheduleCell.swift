//
//  ScheduleCell.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 14.06.2025.
//
import UIKit

class ScheduleCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ScheduleCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemGray6
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with event: Event?) {
        
        if let event = event {
            backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        } else {
            backgroundColor = UIColor.white
        }
    }
}
