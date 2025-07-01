//
//  testViewController.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 04.06.2025.
//

import UIKit

class ScheduleViewController: UIViewController {
   
    private let viewModel: ScheduleViewModel
    private let mainView: ScheduleView = .init()
    private lazy var dataSource = ScheduleDataSource(viewModel: viewModel)
    
    init(viewModel: ScheduleViewModel = ScheduleViewModel()) {
        self.viewModel = viewModel
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
        
        mainView.scheduleCollectionView.delegate = self
        mainView.scheduleCollectionView.dataSource = dataSource
        mainView.scheduleCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.05)
        
        viewModel.onDataChanged = { [weak self] in
            guard let self = self else { return }
            self.mainView.monthLabel.text = self.viewModel.monthYearText
            self.mainView.scheduleCollectionView.reloadData()
        }
        
        setupSwipeGestures()
        setupObservers()
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
        
        let direction = gesture.direction
        let offsetX = direction == .left ? view.bounds.width : -view.bounds.width
        
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.scheduleCollectionView.transform = CGAffineTransform(
                translationX: -offsetX, y: 0
            )
        }, completion: { _ in
            if gesture.direction == .left {
                self.viewModel.nextWeek()
            } else if gesture.direction == .right {
                self.viewModel.previousWeek()
            }
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
        
        let startDate = viewModel.dateFor(section: indexPath.section, item: indexPath.item)
        
        let formVC = LessonFormViewController()
        formVC.startDate = startDate
        formVC.lessonManager = viewModel.lessonManager
        if let lesson = viewModel.getLesson(at: startDate) {
            formVC.isEditMode = true
            formVC.editingLesson = lesson
        }
        present(UINavigationController(rootViewController: formVC), animated: true)
    }
}

extension Notification.Name {
    static let lessonsDidUpdate = Notification.Name("lessonsDidUpdate")
}
