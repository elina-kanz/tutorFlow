//
//  LessonFormViewController.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 20.06.2025.
//

import UIKit

class LessonFormViewController: UIViewController {
    
    var lessonManager: LessonManager!
    var startDate: Date!
    
    
    private let mainView = LessonFormView.init()
    private var selectedStudents: [Student] = []
    private var selectedDuration = 60
    
    override func loadView() {
        view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupDatePickers()
    }
    
    private func setupNavBar() {
        
        title = "New Lesson"
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveTapped)
        )
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        
        let lessonData = LessonManager.LessonData(
            startDate: mainView.datePicker.date,
            duration: TimeInterval(selectedDuration * 60),
            title: mainView.titleTextField.text ?? "New Lesson",
            students: selectedStudents
        )
        
        lessonManager.addLesson(lessonData)
        
        NotificationCenter.default.post(name: .lessonsDidUpdate, object: nil)
        
        dismiss(animated: true) {
            if let presenter = self.presentingViewController as? ScheduleViewController {
                presenter.reloadCollectionView()
            }
        }
    }
    
    private func setupDatePickers() {
        
        mainView.datePicker.date = startDate
        mainView.datePicker.minimumDate = startDate
        mainView.datePicker.maximumDate = Calendar.current.date(byAdding: .month, value: 3, to: startDate)
        
        mainView.durationPicker.delegate = self
        mainView.durationPicker.dataSource = self
    }
    
}

extension  LessonFormViewController: UIPickerViewDelegate {
    
}

extension LessonFormViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        12
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        12
    }
}


