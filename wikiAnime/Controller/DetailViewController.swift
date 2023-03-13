//
//  DetailViewController.swift
//  wikiAnime
//i
//  Created by Sebas's Mac on 11/11/22.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var serieStatus: UILabel!
    @IBOutlet weak var nextRelease: UILabel!
    @IBOutlet weak var numberEpisode: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var serieDescription: UILabel!
    @IBOutlet weak var coverImageOriginal: UIImageView!
    @IBOutlet weak var detailActivityIndicator: UIActivityIndicatorView!
    
    var serieId: String?
    var serieManager = ApiManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailActivityIndicator.startAnimating()
        
        getSerieDetail()
    }
    
    func getSerieDetail(){
        
        if let animeId = serieId {
            
            serieManager.getAnimeSerie(serieId: animeId) { detailSerieData in
                
                self.detailActivityIndicator.stopAnimating()
                self.detailActivityIndicator.hidesWhenStopped = true
                self.showSerie(serie: detailSerieData.data)
                
            } failure: { error in
                
                self.detailActivityIndicator.stopAnimating()
                self.detailActivityIndicator.hidesWhenStopped = true
                self.displayErrorAlert()
            }
        }
    }
    
    func showSerie(serie:Serie){
        
        //Valida coverImage
        if let coverImage = serie.attributes.coverImage?.original {
            
            self.coverImageOriginal.sd_setImage(with: URL(string: coverImage))
            
        } else if let posterImage = serie.attributes.posterImage?.tiny {
            
            self.coverImageOriginal.sd_setImage(with: URL(string: posterImage))
        }
        
        //Valida title
        if let serieTitle = serie.attributes.canonicalTitle {
            
            self.title = serieTitle
        }
        
        //Valida initialDate
        if let initialDate = serie.attributes.startDate {
            
            self.startDate.text = initialDate
        }
        
        //Valida finalDate
        if let finalDate = serie.attributes.endDate {
            
            self.endDate.text = finalDate
            
        } else {
            
            self.endDate.text = K.finalDate
        }
        
        //Valida status
        if let animeStatus = serie.attributes.status {
            
            self.serieStatus.text = animeStatus
        }
        
        //Valida description
        if let animeDescription = serie.attributes.synopsis {
            
            self.serieDescription.text = animeDescription
        }
        
        //Valida nextRelease
        if let nextEpisode = serie.attributes.nextRelease {
            
            self.nextRelease.text = nextEpisode
        }
        
        //Valida numberEpisode
        if let espisodeNumber = serie.attributes.episodeCount {
            
            self.numberEpisode.text = String("\(espisodeNumber) espisodes")
        }
        
        // Valida duration
        if let serieDuration = serie.attributes.episodeLength {
            
            self.duration.text = String("\(serieDuration) minutes")
        }
    }
    
    func displayErrorAlert() {
        let alert = UIAlertController(title: "Oops!",
                                      message: "Parece que algo no salió bien, por favor intenta de nuevo",
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Volver",
                                              style: UIAlertAction.Style.default,
                                              handler: {(_: UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
        
        alert.addAction(UIAlertAction(title: "Reintentar",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            self.getSerieDetail()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
