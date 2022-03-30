import UIKit

class ButtonViewController: UIViewController {
    
    private var tableViewButton = UIButton(type: .system)

    var output: ButtonViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton(button: tableViewButton, title: "TableView")
        tableViewButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        postButton()
        
        view.backgroundColor = .white
        
        view.addSubview(tableViewButton)
    }
    
    private func setupButton(button: UIButton, title: String) {
        button.backgroundColor = .black
        button.layer.cornerRadius = 4
        button.tintColor = .white
        button.setTitle(title, for: .normal)
    }
    private func postButton() {
        
        tableViewButton.frame = CGRect(x: 50,
                                       y: UIScreen.main.bounds.height / 2 - 40 / 2,
                                       width: UIScreen.main.bounds.width - 100,
                                       height: 40)
    }
    
    @objc private func didTap() {
        output.didTapTableViewButton()
    }
}

// MARK: - ButtonViewInput

extension ButtonViewController: ButtonViewInput {
    
}


