import UIKit

class DiscoverViewController: UIViewController {
    
    private var viewModel = DiscoverViewModel()
    private let tableView = UITableView()
    lazy var refreshControl = UIRefreshControl()
    private lazy var avatarImage: UIImage? = {
        return UIImage(named: "avatar_4")?
            .scaledToSize(size: CGSize(width: 50, height: 50))
            .roundedImage(cornerRadius: 17)
            .withRenderingMode(.alwaysOriginal)
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchPosts()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = UIColor(named: "appColor")
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        // Sol buton
        if let avatarImage = avatarImage {
            let avatarButton = UIBarButtonItem(image: avatarImage, style: .plain, target: self, action: #selector(leadingButtonTapped))
            navigationItem.leftBarButtonItem = avatarButton
        }
        
        // Sağ buton
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(trailingButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        // Büyük başlık
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Discover"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "appColor")
        tableView.separatorStyle = .none
        tableView.register(PostCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Actions
    @objc private func leadingButtonTapped() {
        // Sol buton tıklandığında yapılacak işlemler
    }
    
    @objc private func trailingButtonTapped() {
        // Sağ buton tıklandığında yapılacak işlemler
    }
    @objc func refresh(){
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    // MARK: - Data Fetching
    private func fetchPosts() {
        viewModel.fetchPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                self.viewModel.posts = posts
                self.tableView.reloadData() // TableView'i yeniden yükle
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

// MARK: - TableView Delegate & DataSource
extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! PostCell
        let post = viewModel.posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! TableViewHeader
        
        headerView.headerItem.titleLabel.text = "\(viewModel.posts.count) Active Polls"
        return headerView
    }
    
}
