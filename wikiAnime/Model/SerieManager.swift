//
//  SerieManager.swift
//  wikiAnime
//
//  Created by Sebastian Güiza on 2/11/22.
//

import Foundation

protocol SerieManagerDelegate {
    
    func didGetSeries(series: [SerieData])
    func didFailWithError(error: Error)
}

struct SerieManager {
    
    let serieURL = "https://kitsu.io/api/edge/anime"
    
    var delegate: SerieManagerDelegate?
    
    func performRequest(){
        
        if let url = URL(string: serieURL){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if let safeError = error {
                    
                    self.delegate?.didFailWithError(error: safeError)
                    return
                }
                
                //Si data no es nulo, guarde el valor en safeData
                if let safeData = data {
                    
                    if let serie:AnimeData = self.parseJson(safeData){
                        self.delegate?.didGetSeries(series: serie.data)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(_ serieJSON: Data) -> AnimeData? {
        
        let decoder = JSONDecoder()
        
        do {
            let animeData = try decoder.decode(AnimeData.self, from: serieJSON)
            
            return animeData
            
        } catch {
            
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
