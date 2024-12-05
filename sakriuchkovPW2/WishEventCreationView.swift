import UIKit

final class WishEventCreationView: UIViewController {
    
    struct WishEventModel {
        let title: String
        let description: String
        let startDate: Date
        let endDate: Date
    }
    
    // MARK: - UI Элементы
    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()
    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()
    private let saveButton = UIButton(type: .system)
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    // MARK: - Настройка UI
    private func configureUI() {
        configureTextFields()
        configureDatePickers()
        configureSaveButton()
    }
    
    private func configureTextFields() {
        titleTextField.placeholder = "Введите название"
        descriptionTextField.placeholder = "Введите описание"
        titleTextField.borderStyle = .roundedRect
        descriptionTextField.borderStyle = .roundedRect
        
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        
        titleTextField.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        titleTextField.pinHorizontal(to: view, 16)
        
        descriptionTextField.pinTop(to: titleTextField.bottomAnchor, 10)
        descriptionTextField.pinHorizontal(to: view, 16)
    }
    
    private func configureDatePickers() {
        startDatePicker.datePickerMode = .dateAndTime
        endDatePicker.datePickerMode = .dateAndTime
        
        view.addSubview(startDatePicker)
        view.addSubview(endDatePicker)
        
        startDatePicker.pinTop(to: descriptionTextField.bottomAnchor, 20)
        startDatePicker.pinHorizontal(to: view, 16)
        
        endDatePicker.pinTop(to: startDatePicker.bottomAnchor, 10)
        endDatePicker.pinHorizontal(to: view, 16)
    }
    
    private func configureSaveButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        
        view.addSubview(saveButton)
        saveButton.pinTop(to: endDatePicker.bottomAnchor, 20)
        saveButton.pinCenterX(to: view)
    }
    
    // MARK: - Сохранение события
    @objc private func saveEvent() {
        let title = titleTextField.text ?? "Без названия"
        let description = descriptionTextField.text ?? "Без описания"
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        
        let newEvent = WishEventModel(title: title, description: description, startDate: (startDate), endDate: (endDate))
        
        // Сохранение в CoreData или массив (добавьте вашу логику)
        print("Новое событие: \(newEvent)")
        
        dismiss(animated: true)
    }
    
    @objc private func openEventCreationView() {
        let eventCreationVC = WishEventCreationView()
        present(eventCreationVC, animated: true)
    }

}

