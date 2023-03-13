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
    @IBOutlet weak var animesActivityIndicator: UIActivityIndicatorView!
    
    var serieManager = ApiManager()
    var animeSeries: [Anime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animesActivityIndicator.startAnimating()
        
        seriesTableView.delegate = self
        seriesTableView.dataSource = self
        seriesTableView.register(UINib(nibName: K.cellNibName, bundle: nil),forCellReuseIdentifier: K.cellIdentifier)
        
        title = "WikiAnime"
        getAnimesList()
    }
    
    func getAnimesList(){
        
        serieManager.getAnimesList { animesListData in
            
            self.animeSeries = animesListData.data
            self.seriesTableView.reloadData()
            self.animesActivityIndicator.stopAnimating()
            self.animesActivityIndicator.hidesWhenStopped = true
            
        } failure: { error in
            
            self.animesActivityIndicator.stopAnimating()
            self.animesActivityIndicator.hidesWhenStopped = true
            self.displayErrorAlert()
        }
    }
    
    func displayErrorAlert() {
        let alert = UIAlertController(title: "Oops!",
                                      message: "Parece que algo no salió bien, por favor intenta de nuevo",
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Reintentar",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.getAnimesList()
        }))
        self.present(alert, animated: true, completion: nil)
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
