import UIKit

final class InitialViewController: UIViewController {
    
    private lazy var tableView = UITableView(frame: CGRect.zero, style: .grouped)
    private var openedViewController: UIViewController?
    
    private let titles = ["ЛР3", "ЛР4", "ЛР5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        setupConstraints()
    }
    
    private func setupTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InitialViewControllerCell.self, forCellReuseIdentifier: "InitialViewControllerCell")
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension InitialViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InitialViewControllerCell") as? InitialViewControllerCell
        cell?.configure(title: titles[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "Main")
            present(viewController, animated: true)
        case 1:
            let viewController = CodeTableViewController()
            present(viewController, animated: true)
        case 2:
            let builder = ButtonModuleBuilder()
            let viewController = builder.build(output: self)
            present(viewController, animated: true)
        default:
            return
        }
    }
}

extension InitialViewController: UITableViewDelegate {
    
}

// MARK: - TableModuleOutput

extension InitialViewController: TableModuleOutput {
    func tableModuleWantsToOpenFuncView() {
        presentedViewController?.dismiss(animated: true) { [weak self] in
            guard let strongSelf = self else { return }
            
            let viewController = CodeFuncViewController()
            strongSelf.openedViewController = viewController
            strongSelf.present(viewController, animated: true)
        }
    }
    
}


// MARK: - ButtonModuleOutput

extension InitialViewController: ButtonModuleOutput {
    func buttonWantsToOpenTable() {
        presentedViewController?.dismiss(animated: true) { [weak self] in
            guard let strongSelf = self else { return }
            
            let builder = TableModuleBuilder()
            let viewController = builder.build(output: strongSelf)
            strongSelf.openedViewController = viewController
            strongSelf.present(viewController, animated: true)
        }
    }
}
