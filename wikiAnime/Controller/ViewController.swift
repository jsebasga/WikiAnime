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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seriesTableView.dataSource = self
        
        seriesTableView.register(UINib(nibName: K.cellNibName, bundle: nil),forCellReuseIdentifier: K.cellIdentifier)
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.animes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! SerieCell
        cell.titleLabel.text = K.animes[indexPath.row]
        cell.subtitleLabel.text = K.animes[indexPath.row]
        
        return cell
    }
}
