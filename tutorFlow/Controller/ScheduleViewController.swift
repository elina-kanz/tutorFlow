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
        mainView.pagerCollectionView.reloadData()
    }
    
    private func setupCollectionView() {
        mainView.pagerCollectionView.dataSource = self
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

extension UIViewController {
    func setupNavBar(title: String) {
        self.navigationItem.title = title
    }
}

// MARK: - UICollectionViewDataSource

