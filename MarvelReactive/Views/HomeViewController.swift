//
//  HomeViewController.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 26/06/2021.
//

import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import UIKit

class HomeViewController: UIViewController {
    let viewModel: HomeViewModel
    
    private let disposeBag = DisposeBag()
    private var tableView: UITableView = UITableView()
    
    public init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    private func setupViews() {
        title = NSLocalizedString("Characters", comment: "")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.largeTitleDisplayMode = .never

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    private func bind() {
        viewModel.marvelCharacters
            .drive(tableView.rx.items(cellIdentifier: DetailsCell.reuseIdentifier, cellType: DetailsCell.self)) { (row , character, cell) in
                let cellViewModel = DetailsCellViewModel(characters: character)
                cell.bind(to: cellViewModel)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MarvelCharacter.self)
            .bind(to: viewModel.selectCharacter)
            .disposed(by: disposeBag)
    }
}

extension UITableView {
    func register(_ cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass.self))
    }
}
