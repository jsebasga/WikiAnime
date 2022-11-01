//
//  ViewController.swift
//  wikiAnime
//
//  Created by Sebastian Güiza on 1/11/22.
//

import UIKit

//MARK: - UIViewController

class ViewController: UIViewController {

    @IBOutlet weak var seriesTableView: UITableView!
    
    let animes = ["Bleach","One Piece","Naruto","Boku no Hero","Doctor Stone","FMB","Spy x Family","Jujutsu Kaisen","Chainsawman","Shingeky no Kyojin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seriesTableView.dataSource = self
        
        seriesTableView.register(UINib(nibName: "SerieCell", bundle: nil),forCellReuseIdentifier: "ReusableCell")
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! SerieCell
        cell.titleLabel.text = animes[indexPath.row]
        cell.subtitleLabel.text = animes[indexPath.row]
        
        return cell
    }
}
