import Foundation
import UIKit

final class InitialViewControllerCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 10,
                                 y: 10,
                                 width: frame.width - 20,
                                 height: frame.height - 20)
    }
    
    private func setupViews() {
        addSubview(titleLabel)
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
