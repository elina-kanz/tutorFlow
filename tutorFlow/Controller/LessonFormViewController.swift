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
    var isEditMode = false
    var editingLesson: Lesson?
    
    private let mainView = LessonFormView.init()
    
    private var selectedDuration = 0
    private let searchStudentController = UISearchController(searchResultsController: nil)
    private var allStudents: [Student] = []
    private var filteredStudents: [Student] = []
    private var selectedStudents: [Student] = []

    override func loadView() {
        view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupDatePickers()
        setupStudentSearch()
        
        if isEditMode, let lesson = editingLesson {
            loadLessonData(lesson)
            
            mainView.deleteButton.isHidden = false
            mainView.deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        } else {
            title = "New Lesson"
        }
    }
    
    private func setupNavBar() {
    
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
            duration: mainView.durationPicker.selectedRow(inComponent: 0),
            title: mainView.titleTextField.text ?? "New Lesson",
            students: selectedStudents
        )
        
        if isEditMode, let lesson = editingLesson {
            lessonManager.updateLesson(lesson, with: lessonData)
        } else {
            lessonManager.addLesson(lessonData)
        }
        
        NotificationCenter.default.post(name: .lessonsDidUpdate, object: nil)
        
        dismiss(animated: true) {
            if let presenter = self.presentingViewController as? ScheduleViewController {
                presenter.reloadCollectionView()
            }
        }
    }
    
   @objc private func deleteTapped() {
        guard let lesson = editingLesson else { return }
        
        let alert = UIAlertController(
            title: "Delete Lesson",
            message: "Are you sure you want to delete this lesson?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) {_ in
            self.lessonManager.deleteLesson(lesson)
            NotificationCenter.default.post(name: .lessonsDidUpdate, object: nil)
            self.dismiss(animated: true)
            if let presenter = self.presentingViewController as? ScheduleViewController {
                presenter.reloadCollectionView()
            }
        })
        
        present(alert, animated: true)
        
    }
    
    private func setupDatePickers() {
        
        mainView.datePicker.date = startDate
        mainView.datePicker.minimumDate = startDate
        mainView.datePicker.maximumDate = Calendar.current.date(byAdding: .month, value: 3, to: startDate)
        
        mainView.durationPicker.delegate = self
        mainView.durationPicker.dataSource = self
        
        if let defaultIndexDuration = Constants.durationOptions.firstIndex(of: 60) {
            mainView.durationPicker.selectRow(defaultIndexDuration, inComponent: 0, animated: false)
            selectedDuration = 60
        }
    }
    
    private func setupStudentSearch() {
 
        searchStudentController.searchResultsUpdater = self
        searchStudentController.obscuresBackgroundDuringPresentation = false
        searchStudentController.searchBar.placeholder = "Search Student"
        navigationItem.searchController = searchStudentController
        definesPresentationContext = true
        
        mainView.studentsTableView.delegate = self
        mainView.studentsTableView.dataSource = self
    }
    
    
    private func loadLessonData(_ lesson: Lesson) {
        
        title = lesson.title
        mainView.titleTextField.text = lesson.title
        mainView.datePicker.date = lesson.startDate
        selectedDuration = lesson.duration
        
        if let index = Constants.durationOptions.firstIndex(of: selectedDuration) {
            mainView.durationPicker.selectRow(index, inComponent: 0, animated: false)
        }
        
        selectedStudents = lesson.students
        mainView.studentsTableView.reloadData()
    }
    
    private func loadStudents() {
        allStudents = StudentManager.shared.getAllStudents()
        filteredStudents = allStudents
        mainView.studentsTableView.reloadData()
    }
    
}

extension  LessonFormViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(Constants.durationOptions[row]) min"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedDuration = Constants.durationOptions[row]
    }
}

extension LessonFormViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Constants.durationOptions.count
    }
}

extension LessonFormViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        if searchText.isEmpty {
            filteredStudents = allStudents
        } else {
            filteredStudents = allStudents.filter {
                $0.name?.lowercased().contains(searchText) ?? false
            }
        }
        
        mainView.studentsTableView.reloadData()
    }
}

extension LessonFormViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredStudents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.reuseIdentifier, for: indexPath)
        let student = filteredStudents[indexPath.row]
        
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(student.surname!) \(student.name!)"
        content.image = UIImage(systemName: selectedStudents.contains(where: {$0.id == student.id }) ? "check.circle.fill" : "circle")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let student = filteredStudents[indexPath.row]
        
        if let index = selectedStudents.firstIndex(where: { $0.id == student.id }) {
            selectedStudents.remove(at: index)
        } else {
            selectedStudents.append(student)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension LessonFormViewController: UITableViewDataSource {
    
}
