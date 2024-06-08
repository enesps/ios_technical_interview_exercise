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
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        addSubview(imageView)
        addSubview(likeButton)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        likeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(30)
        }
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image?.scaledToSize(size: CGSize(width: 100, height: 100))
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

