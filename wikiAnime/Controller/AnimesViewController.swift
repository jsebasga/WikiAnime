//
//  ViewController.swift
//  wikiAnime
//
//  Created by Sebastian Güiza on 1/11/22.
//

import UIKit

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
        serieManager.delegate = self
        serieManager.getAnimesList()
        
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
        let idSeries = animeSerie.id
        print (idSeries)
        
        if let safeTinyImage = animeSerie.attributes?.posterImage?.tiny{
            
            cell.posterImage.loadFrom(URLAddress: safeTinyImage)
        }
        cell.enTitleLabel.text = animeSerie.attributes?.titles?.en
        cell.enJpTitleLabel.text = animeSerie.attributes?.titles?.en_jp
        cell.jaTitleLabel.text = animeSerie.attributes?.titles?.ja_jp
        
        return cell
    }
}

//MARK: - SerieManagerDelegate

extension AnimesViewController: ApiManagerDelegate{
    func didGetSeries(series: [Anime]) {
        
        animeSeries = series
        DispatchQueue.main.async {
            
            self.seriesTableView.reloadData()
    
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension UIImageView {
    
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

//MARK: - UITableViewDelegate

extension AnimesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let animeSerie = animeSeries[indexPath.row]
        
        performSegue(withIdentifier: K.goToDetail , sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! DetailViewController
        
        if let indexPath = seriesTableView.indexPathForSelectedRow {
            destinationVC.serieId = animeSeries[indexPath.row].id
         }
    }
}
