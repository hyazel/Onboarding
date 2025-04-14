import UIKit

class RadioButton: UIControl {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let radioCircle: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelection()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor(white: 1, alpha: 0.25)
        layer.cornerRadius = 12
        layer.borderWidth = 0
        layer.masksToBounds = true
        
        addSubview(radioCircle)
        radioCircle.addSubview(checkmarkImageView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // Radio circle
            radioCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            radioCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            radioCircle.widthAnchor.constraint(equalToConstant: 24),
            radioCircle.heightAnchor.constraint(equalToConstant: 24),
            
            // Checkmark
            checkmarkImageView.centerXAnchor.constraint(equalTo: radioCircle.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: radioCircle.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 12),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 12),
            
            // Title
            titleLabel.leadingAnchor.constraint(equalTo: radioCircle.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Button height
            heightAnchor.constraint(equalToConstant: 56)
        ])
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    private func updateSelection() {
        radioCircle.backgroundColor = isSelected ? .systemBlue : .clear
        radioCircle.layer.borderColor = (isSelected ? UIColor.systemBlue : UIColor.systemGray).cgColor
        checkmarkImageView.isHidden = !isSelected
        
        layer.borderWidth = isSelected ? 1 : 0
        layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @objc private func handleTap() {
        isSelected.toggle()
        sendActions(for: .valueChanged)
    }
} 
