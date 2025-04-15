import UIKit

public protocol RadioGroupDelegate: AnyObject {
    func radioGroup(_ radioGroup: RadioGroup, didSelectOption option: String)
}

public class RadioGroup: UIView {
    public weak var delegate: RadioGroupDelegate?
    private var radioButtons: [RadioButton] = []
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public init(options: [String]) {
        super.init(frame: .zero)
        setupRadioButtons(with: options)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRadioButtons(with options: [String]) {
        radioButtons = options.map { option in
            let button = RadioButton()
            button.title = option
            button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .valueChanged)
            return button
        }
    }
    
    private func setupLayout() {
        addSubview(stackView)
        radioButtons.forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func radioButtonTapped(_ sender: RadioButton) {
        radioButtons.forEach { button in
            button.isSelected = button == sender
        }
        delegate?.radioGroup(self, didSelectOption: sender.title)
    }
    
    var selectedOption: String? {
        radioButtons.first { $0.isSelected }?.title
    }
} 
