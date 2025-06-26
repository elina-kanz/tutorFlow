//
//  testViewController.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 04.06.2025.
//

import UIKit

class ScheduleViewController: UIViewController {
   
    var lessonManager = LessonManager()
    
    private let mainView: ScheduleView = .init()
    private var currentWeekStartDate = Date().startOfWeek()
    private var daysOfWeek: [Date] = []
    
    override func loadView() {
        view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Schedule"
        // configure()
        setupCollectionView()
        setupMonthYear()
        setupWeekDays()
        setupSwipeGestures()
        setupObservers()
        mainView.scheduleCollectionView.reloadData()
    }
    
    private func setupCollectionView() {
        mainView.scheduleCollectionView.delegate = self
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
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLessonsUpdate),
            name: .lessonsDidUpdate,
            object: nil
        )
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
    
    @objc private func handleLessonsUpdate() {
        reloadCollectionView()
    }
    
    func reloadCollectionView() {
        UIView.performWithoutAnimation {
            mainView.scheduleCollectionView.reloadData()
            mainView.scheduleCollectionView.layoutIfNeeded()
        }
    }
    
}

extension ScheduleViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDay = daysOfWeek[indexPath.item]
        let selectedHour = indexPath.section
        
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDay)
        dateComponents.hour = selectedHour
        dateComponents.minute = 0
        
        guard let startDate = calendar.date(from: dateComponents) else { return }
        
        let formVC = LessonFormViewController()
        formVC.startDate = startDate
        formVC.lessonManager = lessonManager
        if let index = lessonManager.lessons.firstIndex(where: {$0.startDate == startDate}) {
            formVC.isEditMode = true
            formVC.editingLesson = lessonManager.lessons[index]
        }
        present(UINavigationController(rootViewController: formVC), animated: true)
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.reuseIdentifier, for: indexPath) as! ScheduleCell
        
        let day = daysOfWeek[indexPath.item]
        let hour = indexPath.section
        
        let calendar = Calendar.current
        
        guard let slotStartDate = calendar.date(
            bySettingHour: hour,
            minute: 0,
            second: 0,
            of: day
        ) else { return cell }
        
        if let lesson = lessonManager.lessonAt(at: slotStartDate) {
            cell.configureBookedCell(cell, with: lesson)
        } else {
            cell.configureFreeCell(cell, for: slotStartDate)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == DayHeaderView.elementKind {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DayHeaderView.reuseIdentifier, for: indexPath) as! DayHeaderView
            
            let date = daysOfWeek[indexPath.item]
            view.dayLabel.text = date.dayWeekString()
            view.dateLabel.text = date.dateString()
            
            let isToday = Calendar.current.isDateInToday(date)
            
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

extension Notification.Name {
    static let lessonsDidUpdate = Notification.Name("lessonsDidUpdate")
}
