//
//  ViewController.swift
//  sakriuchkovPW2
//
//  Created by Sergey on 29.10.2024.

import UIKit

final class WishMakerViewController: UIViewController {
    
    // MARK: Описание переменных (для читабельности).
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        
        static let stackRaius: CGFloat = 20
        static let stackBottom: CGFloat = -20
        static let stackLeading: CGFloat = 20
        
        static let titleViewFont: CGFloat = 35
        static let titleViewLeading: CGFloat = 105
        static let titleViewTopAnchor: CGFloat = 30
        
        static let descriptionViewFont: CGFloat = 18
        static let descriptionViewLeading: CGFloat = 20
        static let descriptionViewTopAnchor: CGFloat = 20
        
        // MARK: HW-3
        static let buttonHeight: CGFloat = 40
        static let buttonBottom: CGFloat = 15
        static let buttonSide: CGFloat = 20
        static let buttonText: String = "My wishes"
        static let buttonRadius: CGFloat = 20
        
    }
    
    private let titleView = UILabel()
    private let descriptionView = UILabel()
    // MARK: HW-3
    private let addWishButton: UIButton = UIButton(type: .system)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Заголовок, описание, слайдеры.
    private func configureUI() {
        view.backgroundColor = .systemCyan
        configureTitle()
        configureDescription()
        addWishButtonPressed()
        configureAddWishButton()
        configureSliders()
    }
    
    // MARK: Описание заголовка.
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = "WishMaker"
        titleView.font = UIFont.systemFont(ofSize: Constants.titleViewFont, weight: .bold)
        titleView.textColor = .systemPurple
        
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleViewLeading),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleViewTopAnchor)
        ])
    }
    
    // MARK: Описание description.
    private func configureDescription() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = """
                Look.. If you had..
                One shot, or one opportunity
                To seize everything you ever wanted.. In one moment
                Would you capture it.. Or just let it slip? Yo..
                But I know that most of all you want to change the color😅
                """
        descriptionView.font = UIFont.systemFont(ofSize: Constants.descriptionViewFont)
        descriptionView.numberOfLines = 0 // MARK: Для переноса строк автоматически.
        descriptionView.textColor = .systemPink
        
        view.addSubview(descriptionView)
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descriptionViewLeading),
            descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.descriptionViewTopAnchor)
        ])
    }
    
    // MARK: Описание слайдеров.
    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRaius
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            stack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
            stack.bottomAnchor.constraint(equalTo: addWishButton.topAnchor, constant: Constants.stackBottom)
        ])
        
        sliderRed.valueChanged = { [weak self] value in
            guard let self = self else { return }
            let red = CGFloat(value)
            let green = CGFloat(sliderGreen.slider.value)
            let blue = CGFloat(sliderBlue.slider.value)
            self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            guard let self = self else { return }
            let red = CGFloat(sliderRed.slider.value)
            let green = CGFloat(value)
            let blue = CGFloat(sliderBlue.slider.value)
            self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }

        sliderBlue.valueChanged = { [weak self] value in
            guard let self = self else { return }
            let red = CGFloat(sliderRed.slider.value)
            let green = CGFloat(sliderGreen.slider.value)
            let blue = CGFloat(value)
            self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
    // MARK: HW-3
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.pinBottom(to: view, Constants.buttonBottom)
        addWishButton.pinHorizontal(to: view, Constants.buttonSide)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)
        
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    // MARK: HW-3
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
}


// MARK: Создание слайдеров.
final class CustomSlider: UIView {
    
    enum SliderConstants {
        static let titleViewLeading: CGFloat = 20
        static let titleViewTopAnchor: CGFloat = 10
        
        static let sliderLeading: CGFloat = 20
        static let sliderBottomAnchor: CGFloat = -10
    }
    
    var valueChanged: ((Double) -> Void)?
    var slider = UISlider()
    var titleView = UILabel()
    
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: SliderConstants.titleViewTopAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SliderConstants.titleViewLeading),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: SliderConstants.sliderBottomAnchor),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SliderConstants.sliderLeading)
            
        ])
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
