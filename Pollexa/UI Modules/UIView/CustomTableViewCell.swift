import UIKit

class PostCell: UITableViewCell {
    private var postId: String?
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        return view
    }()
    
    private let avatarView: AvatarView = {
        return AvatarView(image: nil)
    }()
    
    private let fullNameLabel: TextView = {
        return TextView(text: nil, fontSize: 17, textColor: UIColor(red: 2/255, green: 24/255, blue: 43/255, alpha: 1.0), alignment: .left)
    }()
    
    private let publishDateLabel: TextView = {
        return TextView(text: nil, fontSize: 15, textColor: UIColor(red: 147/255, green: 162/255, blue: 180/255, alpha: 1.0), alignment: .right)
    }()
    
    private let headingLabel: TextView = {
        let label = TextView(text: "Heading", fontSize: 12, textColor: UIColor(red: 91/255, green: 109/255, blue: 131/255, alpha: 1.0), alignment: .left)
        return label
    }()
    
    private let questionLabel: TextView = {
        let label = TextView(text: "Question", fontSize: 17, textColor: UIColor(red: 2/255, green: 24/255, blue: 43/255, alpha: 1.0), alignment: .left)
        label.numberOfLines = 2
        return label
    }()
    
    private let pollOptionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let optionView1: OptionView = {
        return OptionView(image: nil)
    }()
    
    let optionView2: OptionView = {
        return OptionView(image: nil)
    }()
    
    private let votesLabel: VotesLabel = {
        return VotesLabel(text: "Votes")
    }()
    private var selectedOption: OptionView?
    private var voteTimestamp: Date?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        setupViews()
        configureButtonActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(separatorView)
        containerView.addSubview(avatarView)
        containerView.addSubview(fullNameLabel)
        containerView.addSubview(publishDateLabel)
        containerView.addSubview(headingLabel)
        containerView.addSubview(questionLabel)
        containerView.addSubview(pollOptionsStackView)
        containerView.addSubview(votesLabel)

        pollOptionsStackView.addArrangedSubview(optionView1)
        pollOptionsStackView.addArrangedSubview(optionView2)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }

        separatorView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.left.equalTo(containerView).offset(20)
            make.right.equalTo(containerView).offset(-20)
            make.bottom.equalTo(containerView)
        }

        avatarView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.left.equalTo(containerView).offset(20)
            make.top.equalTo(containerView).offset(10)
        }

        fullNameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarView.snp.right).offset(10)
            make.centerY.equalTo(avatarView)
        }

        publishDateLabel.snp.makeConstraints { make in
            make.right.equalTo(containerView).offset(-20)
            make.centerY.equalTo(avatarView)
        }

        headingLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarView.snp.bottom).offset(20)
            make.left.equalTo(containerView).offset(20)
        }

        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(5)
            make.left.equalTo(containerView).offset(20)
            make.right.equalTo(containerView).offset(-20)
        }

        pollOptionsStackView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(20)
            make.left.equalTo(containerView).offset(20)
            make.right.equalTo(containerView).offset(-20)
            make.height.equalTo(170) // Adjust height as needed
        }

        votesLabel.snp.makeConstraints { make in
            make.top.equalTo(pollOptionsStackView.snp.bottom).offset(10)
            make.left.equalTo(containerView).offset(20)
            make.bottom.equalTo(separatorView.snp.top).offset(-10)
        }
    }

    private func configureButtonActions() {
        optionView1.likeButton.addTarget(self, action: #selector(option1Tapped), for: .touchUpInside)
        optionView2.likeButton.addTarget(self, action: #selector(option2Tapped), for: .touchUpInside)
    }

    @objc private func option1Tapped() {
        handleOptionSelection(option: optionView1)
    }

    @objc private func option2Tapped() {
        handleOptionSelection(option: optionView2)
    }

    private func handleOptionSelection(option: OptionView) {
        guard let postId = postId else { return }

        if selectedOption == option {
            selectedOption?.likeButton.tintColor = .white
            selectedOption = nil
        } else {
            selectedOption?.likeButton.tintColor = .white
            option.likeButton.tintColor = .blue
            selectedOption = option
            voteTimestamp = Date()
            updateHeadingLabel()
            
            let selectedOptionKey = (option == optionView1) ? "option_1" : "option_2"
            LikeManager.shared.saveLike(for: postId, option: selectedOptionKey)
            updateVotesLabel()
        }
    }

    private func updateHeadingLabel() {
        guard let postId = postId,
              let like = LikeManager.shared.getLike(for: postId) else {
            headingLabel.text = "Heading"
            return
        }
        
        let elapsedTime = Date().timeIntervalSince(like.timestamp ?? Date())
        let elapsedTimeString = stringFromTimeInterval(interval: elapsedTime)
        headingLabel.text = "Last voted \(elapsedTimeString) ago"
    }

    private func updateVotesLabel() {
        guard let postId = postId else { return }

        let totalVotes = LikeManager.shared.getTotalLikes(for: postId)
        votesLabel.text = "\(totalVotes) Total Votes"

        // Yüzdeleri hesapla ve güncelle
        let likes = LikeManager.shared.getLikes(for: postId)
        let totalLikes = likes.count
        if totalLikes > 0 {
            let option1Votes = likes.filter { $0.optionId == "option_1" }.count
            let option2Votes = likes.filter { $0.optionId == "option_2" }.count
            let option1Percentage = Double(option1Votes) / Double(totalLikes)
            let option2Percentage = Double(option2Votes) / Double(totalLikes)
            optionView1.setPercentage(option1Percentage)
            optionView2.setPercentage(option2Percentage)
        }
    }

    func configure(with post: Post) {
        self.postId = post.id
        fullNameLabel.text = post.user.username
        publishDateLabel.text = post.createdAt.timeAgoDisplay()
        questionLabel.text = post.content
        avatarView.setImage(UIImage(named: post.user.imageName))
        optionView1.setImage(UIImage(named: post.options.first?.imageName ?? ""))
        optionView2.setImage(UIImage(named: post.options.last?.imageName ?? ""))
        
        updateHeadingLabel()
        updateVotesLabel()
    }

    private func stringFromTimeInterval(interval: TimeInterval) -> String {
        let time = NSInteger(interval)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        if hours > 0 {
            return String(format: "%0.2d hours", hours)
        } else if minutes > 0 {
            return String(format: "%0.2d minutes", minutes)
        } else {
            return String(format: "%0.2d seconds", seconds)
        }
    }
}
