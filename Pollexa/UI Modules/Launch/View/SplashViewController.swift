import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    private let viewModel = SplashViewModel()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppIcon"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pollexa"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = UIColor(red: 2/255, green: 24/255, blue: 43/255, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.navigateToMainScreenHandler = { [weak self] in
            self?.showMainScreen()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // ViewModel'den başlatma isteği
        viewModel.start()
    }
    
    private func setupUI() {
        // Arka plan rengi
        view.backgroundColor = UIColor.white
        
        view.addSubview(imageView)
        view.addSubview(appNameLabel)
        
        // SnapKit ile kısıtlamalar
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.centerY).offset(60) // Metnin dikey konumunu ayarlıyoruz
        }
    }
    
    private func showMainScreen() {
        self.presentVC(withIdentifier: "NavigationApp", from: "Main")
    }
}

