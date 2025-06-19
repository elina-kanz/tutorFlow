//
//  ScheduleWeekCell.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 19.06.2025.
//

import UIKit

class WeekCell: UICollectionViewCell {

    static let reuseIdentifier = "WeekCell"
    
    private var daysOfWeek: [Date] = []
    
    lazy var scheduleCollectionView: UICollectionView = {
        let layout = ScheduleGridLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        
        cv.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.reuseIdentifier)
        cv.register(DayHeaderView.self, forSupplementaryViewOfKind: DayHeaderView.elementKind, withReuseIdentifier: DayHeaderView.reuseIdentifier)
        cv.register(HourHeaderView.self, forSupplementaryViewOfKind: HourHeaderView.elementKind, withReuseIdentifier: HourHeaderView.reuseIdentifier)
    
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(scheduleCollectionView)
        
        scheduleCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            scheduleCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scheduleCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scheduleCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scheduleCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(startingFrom startDate: Date) {
        daysOfWeek = startDate.datesForWeek()
        scheduleCollectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WeekCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.reuseIdentifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == DayHeaderView.elementKind {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DayHeaderView.reuseIdentifier, for: indexPath) as! DayHeaderView
            
            let date = daysOfWeek[indexPath.item]
            view.dayLabel.text = date.dayWeekString()
            view.dateLabel.text = date.dateString()
            
            let isToday = Calendar.current.isDateInToday(date)
            
            view.dayLabel.textColor = isToday ? .blue : .gray
            view.dayLabel.font = isToday ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 16)
            
            view.dateLabel.textColor = isToday ? .blue : .gray
            view.dateLabel.font = isToday ? .boldSystemFont(ofSize: 18) : .systemFont(ofSize: 16)
            
            return view
        } else if kind == HourHeaderView.elementKind {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HourHeaderView.reuseIdentifier, for: indexPath) as! HourHeaderView
            
            view.hourLabel.text = "\(indexPath.section):00"
            
            return view
        }
        fatalError("Unexpected supplementary view kind")
    }
}

