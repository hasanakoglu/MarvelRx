//
//  CharacterDetailsViewController.swift
//  MarvelReactive
//
//  Created by Hasan Akoglu on 26/06/2021.
//

import UIKit

class CharacterDetailsViewController: UITableViewController {
    private let character: MarvelCharacter
    
    init(character: MarvelCharacter) {
        self.character = character
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = character.name
        tableView.dataSource = self
        tableView.register(CharacterDetailsTableViewCell.self, forCellReuseIdentifier: CharacterDetailsTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension CharacterDetailsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailsTableViewCell.reuseIdentifier, for: indexPath) as? CharacterDetailsTableViewCell else { return UITableViewCell() }
        
        let cellViewModel = CharacterDetailsCellViewModel(characters: character)
        cell.bind(to: cellViewModel)
        return cell
    }
}
