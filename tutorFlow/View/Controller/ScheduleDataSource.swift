//
//  ScheduleDataSource.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 28.06.2025.
//
import UIKit

class ScheduleDataSource: NSObject, UICollectionViewDataSource {
    
    private let viewModel: ScheduleViewModel
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.hoursInDayCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.daysInWeekCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.reuseIdentifier, for: indexPath) as! ScheduleCell
    
        
        let startDate = viewModel.dateFor(section: indexPath.section, item: indexPath.item)
        
        if let lesson = viewModel.getLesson(at: startDate) {
            cell.configureBookedCell(cell, with: lesson)
        } else {
            cell.configureFreeCell(cell, for: startDate)
        }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        if kind == DayHeaderView.elementKind {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DayHeaderView.reuseIdentifier, for: indexPath) as! DayHeaderView
            
            let date = viewModel.daysOfWeek[indexPath.item]
            view.dayLabel.text = viewModel.dayWeekString(from: date)
            view.dateLabel.text = viewModel.dayMonthString(from: date)
            
            let isToday = viewModel.isToday(date)
            
            view.dayLabel.textColor = isToday ? .blue : .darkGray
            view.dayLabel.font = isToday ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 14)
            
            view.dateLabel.textColor = isToday ? .blue : .darkGray
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

