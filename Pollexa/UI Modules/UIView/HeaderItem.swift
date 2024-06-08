import UIKit

class HeaderItem: UIView {
    
     let rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1.0)
        view.layer.cornerRadius = 20
        return view
    }()
    private let iconLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right.circle.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "2 Active Polls"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
     let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "See Detail"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(white: 1.0, alpha: 0.5)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        addSubview(rectangleView)
        addSubview(iconLabel)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        iconLabel.snp.makeConstraints { make in
                 make.width.height.equalTo(33)
                 make.centerY.equalToSuperview()
                 make.right.equalToSuperview().offset(-21)
             }
             
             titleLabel.snp.makeConstraints { make in
                 make.top.equalToSuperview().offset(15)
                 make.left.equalToSuperview().offset(20)
             }
             
             subtitleLabel.snp.makeConstraints { make in
                 make.top.equalTo(titleLabel.snp.bottom).offset(5)
                 make.left.equalToSuperview().offset(20)
             }
         }
}


class TableViewHeader: UITableViewHeaderFooterView {
    
    let headerItem = HeaderItem()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "appColor")
        addSubview(headerItem)
        headerItem.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(388)
            make.height.equalTo(78)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
