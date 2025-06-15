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
    }
    
    private func setupCollectionView() {
        mainView.daysOfWeekCollectionView.delegate = self
        mainView.daysOfWeekCollectionView.dataSource = self
        mainView.daysOfWeekCollectionView.isPagingEnabled = true
        mainView.daysOfWeekCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.05)
    }
    
    private func setupWeekDays() {
        daysOfWeek = currentWeekStartDate.datesForWeek()
        mainView.daysOfWeekCollectionView.reloadData()
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
        let newDates = currentWeekStartDate.datesForWeek()
        setupMonthYear()
        let tempCopyCollectionView = UICollectionView(
            frame: mainView.daysOfWeekCollectionView.frame,
            collectionViewLayout: mainView.daysOfWeekCollectionView.collectionViewLayout
        )
        tempCopyCollectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.reuseIdentifier)
        tempCopyCollectionView.register(DayHeaderView.self, forSupplementaryViewOfKind: DayHeaderView.elementKind, withReuseIdentifier: DayHeaderView.reuseIdentifier)
        tempCopyCollectionView.register(HourHeaderView.self, forSupplementaryViewOfKind: HourHeaderView.elementKind, withReuseIdentifier: HourHeaderView.reuseIdentifier)
        
        tempCopyCollectionView.dataSource = self
        tempCopyCollectionView.delegate = self
        tempCopyCollectionView.backgroundColor = .clear
        tempCopyCollectionView.isScrollEnabled = false
        view.addSubview(tempCopyCollectionView)
        
        tempCopyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempCopyCollectionView.topAnchor.constraint(equalTo: mainView.monthLabel.bottomAnchor, constant: 10),
            tempCopyCollectionView.leadingAnchor.constraint(equalTo: mainView.contentView.leadingAnchor),
            tempCopyCollectionView.trailingAnchor.constraint(equalTo: mainView.contentView.trailingAnchor),
            tempCopyCollectionView.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        let offsetX = direction == .left ? view.bounds.width : -view.bounds.width
        tempCopyCollectionView.transform = CGAffineTransform(translationX: offsetX, y: 0)
        
        daysOfWeek = newDates
        mainView.daysOfWeekCollectionView.reloadData()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.daysOfWeekCollectionView.transform = CGAffineTransform(
                translationX: -offsetX, y: 0
            )
            tempCopyCollectionView.transform = .identity
        }) { _ in
            self.mainView.daysOfWeekCollectionView.transform = .identity
            tempCopyCollectionView.removeFromSuperview()
        }
    }
}

extension UIViewController {
    func setupNavBar(title: String) {
        self.navigationItem.title = title
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ScheduleViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(collectionView.bounds.width / 7)

        return CGSize(width: width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

// MARK: - UICollectionViewDataSource

extension ScheduleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.reuseIdentifier, for: indexPath)
        
        let day = indexPath.item
        let hour = indexPath.section
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "DayHeader" {
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
        } else if kind == "HourHeader" {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HourHeaderView.reuseIdentifier, for: indexPath) as! HourHeaderView
            
            view.hourLabel.text = "\(indexPath.item):00"
            
            return view
        }
        
        return UICollectionReusableView()
    }
}
