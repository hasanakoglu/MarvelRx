//
//  DetailsCell.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 26/06/2021.
//

import Foundation

import SnapKit
import UIKit
import RxSwift

class DetailsCell: UITableViewCell {
    static let reuseIdentifier = "details"
    var titleLabel: UILabel = UILabel()
    let cardView: UIView = UIView()
    let characterImageView: UIImageView = UIImageView()
    let disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func bind(to viewModel: DetailsCellViewModel) {
        viewModel.name.drive(titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.image.drive(characterImageView.rx.image).disposed(by: disposeBag)
    }

    func setupViews() {
        selectionStyle = .none
        translatesAutoresizingMaskIntoConstraints = false

        cardView.backgroundColor = .white
        cardView.clipsToBounds = true
        cardView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.contentMode = .scaleAspectFit

        contentView.addSubview(cardView)
        cardView.addSubview(characterImageView)
        cardView.addSubview(titleLabel)

        initializeConstraints()
    }

    func initializeConstraints() {
        cardView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalTo(titleLabel.snp.leading).inset(-5)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(20.0)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.0)
            make.centerY.equalTo(characterImageView.snp.centerY)
            make.bottom.equalToSuperview().inset(20.0)
        }
    }
}

