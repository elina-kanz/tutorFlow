//
//  testViewController.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 04.06.2025.
//

import UIKit

class ScheduleViewController: UIViewController {
   
    private var lessonManager: LessonManagerProtocol
    private var studentManager: StudentManagerProtocol
    private var dateManager: DateManagerProtocol
    private var dateFormatterService: DateFormatterServiceProtocol
    
    private let mainView: ScheduleView = .init()
    private lazy var dataSource = ScheduleDataSource(daysOfWeek, dateManager, lessonManager, dateFormatterService)
    private var currentWeekStartDate: Date
    private var daysOfWeek: [Date] = []
    
    init(
        lessonManager: LessonManagerProtocol = LessonManager.shared,
        studentManager: StudentManagerProtocol = StudentManager.shared,
        dateManager: DateManagerProtocol = DateManager(),
        dateFormatterService: DateFormatterServiceProtocol = DateFormatterService()
    ) {
        self.lessonManager = lessonManager
        self.studentManager = studentManager
        self.dateManager = dateManager
        self.dateFormatterService = dateFormatterService
        currentWeekStartDate = dateManager.getCurrentStartOfWeek()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Schedule"
        
        setupCollectionView()
        setupMonthYear()
        setupWeekDays()
        setupSwipeGestures()
        setupObservers()
        mainView.scheduleCollectionView.reloadData()
    }
    
    private func setupCollectionView() {
        mainView.scheduleCollectionView.delegate = self
        mainView.scheduleCollectionView.dataSource = dataSource
       // mainView.scheduleCollectionView.dataSource = self
       // mainView.scheduleCollectionView.isPagingEnabled = true
        mainView.scheduleCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.05)
    }
    
    private func setupWeekDays() {
        daysOfWeek = dateManager.getWeekDates(from: currentWeekStartDate)
        self.dataSource.updateDaysOfWeek(self.daysOfWeek)
        mainView.scheduleCollectionView.reloadData()
    }
    
    private func setupMonthYear() {
        mainView.monthLabel.text = dateFormatterService.monthYearString(from: currentWeekStartDate)
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
            currentWeekStartDate = dateManager.getNextWeekStart(from: currentWeekStartDate)
            swipeWeekWithAnimation(direction: .left)
        } else if gesture.direction == .right {
            currentWeekStartDate = dateManager.getPreviousWeekStart(from: currentWeekStartDate)
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
            self.daysOfWeek = self.dateManager.getWeekDates(from: self.currentWeekStartDate)
            self.dataSource.updateDaysOfWeek(self.daysOfWeek)
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
        
        let startDate = dateManager.getDate(on: selectedDay, at: selectedHour)
        
        let formVC = LessonFormViewController()
        formVC.startDate = startDate
        formVC.lessonManager = lessonManager
        if let lesson = lessonManager.getLesson(at: startDate) {
            formVC.isEditMode = true
            formVC.editingLesson = lesson
        }
        present(UINavigationController(rootViewController: formVC), animated: true)
    }
}

extension Notification.Name {
    static let lessonsDidUpdate = Notification.Name("lessonsDidUpdate")
}
