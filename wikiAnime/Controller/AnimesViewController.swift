//
//  ViewController.swift
//  wikiAnime
//
//  Created by Sebastian Güiza on 1/11/22.
//

import UIKit
import SDWebImage
import Alamofire

//MARK: - UIViewController

class AnimesViewController: UIViewController {
    
    @IBOutlet weak var seriesTableView: UITableView!
    
    var serieManager = ApiManager()
    var animeSeries: [Anime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seriesTableView.delegate = self
        seriesTableView.dataSource = self
        seriesTableView.register(UINib(nibName: K.cellNibName, bundle: nil),forCellReuseIdentifier: K.cellIdentifier)
        
        title = "WikiAnime"
        getAnimesList()
    }
    
    func getAnimesList(){
        
        serieManager.getAnimesList { animesListData in
            
            print("*******\(animesListData)")
            self.animeSeries = animesListData.data
            self.seriesTableView.reloadData()
            
        } failure: { error in
            
            print("******error\(error)")
        }
    }
}

//MARK: - UITableViewDataSource

extension AnimesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeSeries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! SerieCell
        let animeSerie = animeSeries[indexPath.row]
        
        if let safeTinyImage = animeSerie.attributes?.posterImage?.tiny {
            
            cell.posterImage.sd_setImage(with: URL(string: safeTinyImage))
        }
        cell.enTitleLabel.text = animeSerie.attributes?.titles?.en
        cell.enJpTitleLabel.text = animeSerie.attributes?.titles?.en_jp
        cell.jaTitleLabel.text = animeSerie.attributes?.titles?.ja_jp
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension AnimesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: K.goToDetail , sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! DetailViewController
        
        if let indexPath = seriesTableView.indexPathForSelectedRow {
            destinationVC.serieId = animeSeries[indexPath.row].id
        }
    }
}
