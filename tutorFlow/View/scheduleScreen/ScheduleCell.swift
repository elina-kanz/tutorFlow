//
//  ScheduleCell.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 14.06.2025.
//
import UIKit

class ScheduleCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ScheduleCell"
    
    private lazy var lessonLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 12)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBookedCell(_ cell: ScheduleCell, with lesson: Lesson) {
        cell.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
        cell.layer.borderColor = UIColor.systemBlue.cgColor
        cell.layer.borderWidth = 0.5
        
        lessonLabel.text = lesson.title
    }
    
    func configureFreeCell(_ cell: ScheduleCell, for date: Date) {
        cell.backgroundColor = UIColor.systemBackground
        cell.layer.borderColor = UIColor.systemGray5.cgColor
        cell.layer.borderWidth = 0.5
        
        lessonLabel.text = ""
    }
    
    private func setViews() {
        addSubview(lessonLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            lessonLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            lessonLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            lessonLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            lessonLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
        ])
    }
}
