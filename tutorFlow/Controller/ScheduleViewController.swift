//
//  testViewController.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 04.06.2025.
//

import UIKit

class ScheduleViewController: UIViewController {
   
    private let mainView: ScheduleView = .init()
    private var currentWeekStartDate = Date().startOfWeek()
    private var daysOfWeek: [Date] = []
    
    private var scheduleData: [Date: [Event]] = [:]
    
    
    override func loadView() {
        view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(title: "Schedule")
        // configure()
        setupCollectionView()
        setupMonthYear()
        setupWeekDays()
        setupSwipeGestures()
        mainView.scheduleCollectionView.reloadData()
    }
    
    private func setupCollectionView() {
        mainView.scheduleCollectionView.dataSource = self
        mainView.scheduleCollectionView.isPagingEnabled = true
        mainView.scheduleCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.05)
    }
    
    private func setupWeekDays() {
        daysOfWeek = currentWeekStartDate.datesForWeek()
        mainView.scheduleCollectionView.reloadData()
    }
    
    private func setupMonthYear() {
        let monthYear = "\(currentWeekStartDate.monthString()) \(currentWeekStartDate.yearString())"
        mainView.monthLabel.text = monthYear
    }
    
    private func setupSwipeGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            currentWeekStartDate = currentWeekStartDate.dateByAddingWeeks(1)
            swipeWeekWithAnimation(direction: .left)
        } else if gesture.direction == .right {
            currentWeekStartDate = currentWeekStartDate.dateByAddingWeeks(-1)
            swipeWeekWithAnimation(direction: .right)
        }
    }
    
    private func swipeWeekWithAnimation(direction: UISwipeGestureRecognizer.Direction) {
        
        setupMonthYear()

        let offsetX = direction == .left ? view.bounds.width : -view.bounds.width
        
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.scheduleCollectionView.transform = CGAffineTransform(
                translationX: -offsetX, y: 0
            )
        }, completion: { _ in
            self.daysOfWeek = self.currentWeekStartDate.datesForWeek()
            self.mainView.scheduleCollectionView.collectionViewLayout.invalidateLayout()
            self.mainView.scheduleCollectionView.reloadData()
            self.mainView.scheduleCollectionView.transform = .identity
        })
            
    }
}

extension UIViewController {
    func setupNavBar(title: String) {
        self.navigationItem.title = title
    }
}

// MARK: - UICollectionViewDataSource

extension ScheduleViewController: UICollectionViewDataSource {
    
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
