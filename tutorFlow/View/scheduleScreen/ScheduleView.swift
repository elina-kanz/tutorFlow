//
//  CalendarViewController.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 03.06.2025.
//

import UIKit

class ScheduleView: UIView {
    // MARK: - UI Elements
    
    lazy var contentView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var topPanelStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var pagerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.backgroundColor = UIColor.gray.withAlphaComponent(0.05)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    lazy var monthLabel: UILabel = {
        let element = UILabel()
        element.font = .boldSystemFont(ofSize: 16)
        element.textColor = .black
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        addSubview(contentView)
        
        contentView.addSubview(topPanelStack)
        contentView.addSubview(pagerCollectionView)
        
        topPanelStack.addSubview(monthLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            topPanelStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            topPanelStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topPanelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topPanelStack.heightAnchor.constraint(equalToConstant: 40),
            
            monthLabel.topAnchor.constraint(equalTo: topPanelStack.topAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: topPanelStack.leadingAnchor),
            monthLabel.trailingAnchor.constraint(equalTo: topPanelStack.trailingAnchor),
            monthLabel.heightAnchor.constraint(equalTo: topPanelStack.heightAnchor),
            
            pagerCollectionView.topAnchor.constraint(equalTo: topPanelStack.bottomAnchor, constant: 10),
            pagerCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pagerCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pagerCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}
