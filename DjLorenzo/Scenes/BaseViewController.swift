import UIKit

class BaseViewController: UIViewController {
    
    private let gradientLayer: CAGradientLayer = {
        UIColor.Background.gradientLayer
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    private func setupGradient() {
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
} 
