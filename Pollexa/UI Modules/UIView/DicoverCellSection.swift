import UIKit
class AvatarView: UIView {
     let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.96, alpha: 1.0)
        return imageView
    }()
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image?.scaledToSize(size: CGSize(width: 32, height: 32))
    }
}
class TextView: UILabel {
    init(text: String?, fontSize: CGFloat, textColor: UIColor, alignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = textColor
        self.textAlignment = alignment
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OptionView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .gray // Placeholder color
        return imageView
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13) // Bold font
        label.textColor = .white // White color
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1.0) // Bright background color
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.isHidden = true // Initially hidden
        return label
    }()
    
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        addSubview(imageView)
        addSubview(likeButton)
        addSubview(percentageLabel)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        likeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(30)
        }
        percentageLabel.snp.makeConstraints { make in
                   make.bottom.equalToSuperview().offset(-10) // Top aligned with superview
                   make.right.equalToSuperview().offset(-10) // Right aligned with superview
                   make.width.equalTo(50) // Fixed width
                   make.height.equalTo(20) // Fixed height
               }
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image?.scaledToSize(size: CGSize(width: 100, height: 100))
    }
    
    func setPercentage(_ percentage: Double) {
        percentageLabel.text = "\(Int(percentage * 100))%"
        percentageLabel.isHidden = false
        likeButton.isHidden = true
    }
}
class VotesLabel: UILabel {
    init(text: String?) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: 13)
        self.textColor = UIColor(red: 147/255, green: 162/255, blue: 180/255, alpha: 1.0)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {
    func scaledToSize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
}

