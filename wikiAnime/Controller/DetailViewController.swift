//
//  DetailViewController.swift
//  wikiAnime
//
//  Created by Sebas's Mac on 11/11/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var serieName: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var serieStatus: UILabel!
    @IBOutlet weak var nextRelease: UILabel!
    @IBOutlet weak var numberEpisode: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var serieDescription: UILabel!
    @IBOutlet weak var coverImageOriginal: UIImageView!
    
    var serieId: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var serieManager = ApiManager()
        
        serieManager.delegate = self
        if let animeSerieId = serieId {
            
            serieManager.getAnimeSerie(serieId: animeSerieId)
            print("******\(animeSerieId)")
        }
    
    }
    
}

extension DetailViewController: ApiManagerDelegate {
    
    // TODOS Remove
    func didGetSeries(series: [Anime]) {
        
    }
    
    func didGetSerie(serie: Serie) {
        
        DispatchQueue.main.async {
            
            if let coverImage = serie.attributes.coverImage?.original {
                
                self.coverImageOriginal.loadFrom(URLAddress: coverImage)
                
            } else {
                
                if let posterImage = serie.attributes.posterImage?.tiny {
                    
                    self.coverImageOriginal.loadFrom(URLAddress: posterImage)
                }
            }
            
            if let serieTitle = serie.attributes.canonicalTitle {
                
                self.title = serieTitle
                
            }   else {
                
                self.title = K.noInformation
            }
            
            if let initialDate = serie.attributes.startDate {
                
                self.startDate.text = initialDate
                
            } else {
                
                self.startDate.text = K.noInformation
            }
            
            if let animeStatus = serie.attributes.status {
                
                self.serieStatus.text = animeStatus
                
            } else {
                
                self.serieStatus.text = K.noInformation
            }
            
            if let animeDescription = serie.attributes.synopsis {
                
                self.serieDescription.text = animeDescription
                
            } else {
                
                self.serieDescription.text = K.noInformation
            }
            
            if let finalDate = serie.attributes.endDate {
                
                self.endDate.text = finalDate
            } else {
                
                self.endDate.text = K.finalDate
            }
            
            if let nextEpisode = serie.attributes.nextRelease{
                
                self.nextRelease.text = nextEpisode
            } else {
                
                self.nextRelease.text = K.nextRelease
            }
            
            if let espisodeNumber = serie.attributes.episodeCount{
                
                self.numberEpisode.text = String("\(espisodeNumber) espisodes")
                
            }   else {
                
                self.numberEpisode.text = K.noInformation
            }
            
            if let serieDuration = serie.attributes.episodeLength{
                
                self.duration.text = String("\(serieDuration) minutes")
                
            } else {
                
                self.numberEpisode.text = K.noInformation
            }
        }
    }
    
    func didFailWithError(error: Error) {
        
        print(error)
    }
}
