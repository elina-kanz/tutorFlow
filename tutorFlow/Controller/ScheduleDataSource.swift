//
//  ScheduleDataSource.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 28.06.2025.
//
import UIKit

class ScheduleDataSource: NSObject, UICollectionViewDataSource {
    
    private var daysOfWeek: [Date]
    private var  dateManager: DateManagerProtocol
    private var lessonManager: LessonManagerProtocol
    private var dateFormatterService: DateFormatterServiceProtocol
    
    init(_ daysOfWeek: [Date], _ dateManager: DateManagerProtocol, _ lessonManager:  LessonManagerProtocol, _ dateFormatterService: DateFormatterServiceProtocol) {
        self.daysOfWeek = daysOfWeek
        self.dateManager = dateManager
        self.lessonManager = lessonManager
        self.dateFormatterService = dateFormatterService
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.reuseIdentifier, for: indexPath) as! ScheduleCell
        
        let day = daysOfWeek[indexPath.item]
        let hour = indexPath.section
        
        let startDate = dateManager.getDate(on: day, at: hour)
        
        if let lesson = lessonManager.getLesson(at: startDate) {
            cell.configureBookedCell(cell, with: lesson)
        } else {
            cell.configureFreeCell(cell, for: startDate)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == DayHeaderView.elementKind {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DayHeaderView.reuseIdentifier, for: indexPath) as! DayHeaderView
            
            let date = daysOfWeek[indexPath.item]
            view.dayLabel.text = dateFormatterService.dayWeekString(from: date)
            view.dateLabel.text = dateFormatterService.dateString(from: date)
            
            let isToday = dateManager.isToday(date)
            
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
    
    func updateDaysOfWeek(_ newDays: [Date]) {
        daysOfWeek = newDays
    }
    
}

