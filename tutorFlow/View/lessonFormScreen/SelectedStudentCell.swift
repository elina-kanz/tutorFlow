//
//  SelectedStudentCell.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 28.06.2025.
//
import UIKit

class SelectedStudentCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SelectedStudentCell"
    
    private lazy var studentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        backgroundColor = .blue
        addSubview(studentLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            studentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            studentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            studentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            studentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
        ])
    }
}

