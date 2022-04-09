//
//  RequstTableViewCell.swift
//  LABS
//
//  Created by Погиблов on 07.04.2022.
//

import Foundation
import UIKit

final class CoinTableViewCell: UITableViewCell {
    
    private let logo = UIImageView()
    private let title = UILabel()
    private let subTitle = UILabel()
    
    private let price = UILabel()
    private let volatility = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(coin: Coin?) {
        
        guard let strongCoin = coin else {
            logo.backgroundColor = Constants.Color.loading
            title.backgroundColor = Constants.Color.loading
            subTitle.backgroundColor = Constants.Color.loading 
            return
        }
        
        logo.backgroundColor = Constants.Color.transparent
        title.backgroundColor = Constants.Color.transparent
        subTitle.backgroundColor = Constants.Color.transparent
        
        logo.image = UIImage(named: strongCoin.subtitle)
        title.text = strongCoin.title
        subTitle.text = strongCoin.subtitle
        price.text = String(format: "%.2f", strongCoin.quoteData.valute.price) + " " + "$"
        volatility.text = String(format: "%.2f", strongCoin.quoteData.valute.priceChange1H) + " $ " +  "(" + String(format: "%.2f", strongCoin.quoteData.valute.percentChange1H) + "%)"
        if (strongCoin.quoteData.valute.percentChange1H > 0) {
            setupVolatilityColor(direction: .increase)
        } else {
            setupVolatilityColor(direction: .decrease)
        }
    }
    
    private func setupViews() {
        [logo, title, subTitle, price, volatility].forEach {
            addSubview($0)
        }
    }
    
    private func configureViews() {
        setupLogo()
        setupTitle()
        setupSubTitle()
        setupPrice()
        setupVolatility()
        setupConstraints()
    }
    
    private func setupLogo() {
        logo.backgroundColor = .black
        logo.layer.cornerRadius = Constants.CellSize.imageSize / 2
        logo.layer.masksToBounds = true
        logo.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTitle() {
        title.font = .systemFont(ofSize: Constants.CellSize.heightTitle)
    }
    
    private func setupSubTitle() {
        subTitle.font = .systemFont(ofSize: Constants.CellSize.heightSubTitle)
    }
    
    private func setupPrice() {
        price.font = .systemFont(ofSize: Constants.CellSize.heightTitle)
        price.textAlignment = .right
    }
    
    private func setupVolatilityColor(direction: direction) {
        
        switch direction {
        case .increase:
            volatility.textColor = .systemGreen
        case .decrease:
            volatility.textColor = .red
        }
        
    }
    
    private func setupVolatility() {
        
        volatility.font = .systemFont(ofSize: Constants.CellSize.heightSubTitle)
        volatility.textAlignment = .right
    }
    
    private func setupConstraints() {
        logo.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        price.translatesAutoresizingMaskIntoConstraints = false
        volatility.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logo.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.Padding.defaultValue),
            logo.heightAnchor.constraint(equalToConstant: Constants.CellSize.imageSize),
            logo.widthAnchor.constraint(equalToConstant: Constants.CellSize.imageSize),
            logo.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            title.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: Constants.Padding.defaultValue),
            title.topAnchor.constraint(equalTo: logo.topAnchor),
            title.widthAnchor.constraint(equalToConstant: Constants.CellSize.widthTitles),
            title.heightAnchor.constraint(equalToConstant: Constants.CellSize.heightTitle),
            
            subTitle.leftAnchor.constraint(equalTo: title.leftAnchor),
            subTitle.bottomAnchor.constraint(equalTo: logo.bottomAnchor),
            subTitle.widthAnchor.constraint(equalToConstant: Constants.CellSize.widthTitles),
            subTitle.heightAnchor.constraint(equalToConstant: Constants.CellSize.heightSubTitle),
            
            price.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.Padding.defaultValue),
            price.heightAnchor.constraint(equalToConstant: Constants.CellSize.heightTitle),
            price.widthAnchor.constraint(equalToConstant: Constants.CellSize.widthRigthBlock),
            price.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            
            volatility.rightAnchor.constraint(equalTo: price.rightAnchor),
            volatility.heightAnchor.constraint(equalToConstant: Constants.CellSize.heightSubTitle),
            volatility.widthAnchor.constraint(equalToConstant: Constants.CellSize.widthRigthBlock),
            volatility.centerYAnchor.constraint(equalTo: subTitle.centerYAnchor)
        ])
    }
}

extension CoinTableViewCell {
    private enum direction {
        case increase
        case decrease
    }
    
    private enum Constants {
        enum Color {
            static let transparent: UIColor = .init(white: 0, alpha: 0)
            static let loading: UIColor = .lightGray
        }
        enum Padding {
            static let defaultValue: CGFloat = 14
        }
        enum CellSize {
            static let imageSize: CGFloat = 46
            static let heightTitle: CGFloat = 20
            static let heightSubTitle: CGFloat = 16
            static let widthTitles: CGFloat = 120
            static let widthRigthBlock: CGFloat = 180
        }
    }
}
