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
    
    var serieManager = SerieManager()
    var animeSeries: [SerieData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seriesTableView.dataSource = self
        seriesTableView.register(UINib(nibName: K.cellNibName, bundle: nil),forCellReuseIdentifier: K.cellIdentifier)
        
        serieManager.delegate = self
        serieManager.performRequest()
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeSeries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! SerieCell
        let animeSerie = animeSeries[indexPath.row]
        
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

extension ViewController: SerieManagerDelegate{
    func didGetSeries(series: [SerieData]) {
        
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
