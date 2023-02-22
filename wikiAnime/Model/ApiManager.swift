//
//  SerieManager.swift
//  wikiAnime
//
//  Created by Sebastian Güiza on 2/11/22.
//

import Foundation

protocol ApiManagerDelegate {
    
    func didGetSeries(series: [Anime])
    func didFailWithError(error: Error)
}

struct ApiManager {
    
    let serieURL = "https://kitsu.io/api/edge/anime?page[limit]=10&page[offset]=0"
    
    var delegate: ApiManagerDelegate?
    
    func getAnimesList(){
        
        if let url = URL(string: serieURL){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if let safeError = error {
                    
                    self.delegate?.didFailWithError(error: safeError)
                    return
                }
                
                //Si data no es nulo, guarde el valor en safeData
                if let safeData = data {
                    
                    if let serie:AnimesListData = self.parseJson(safeData){
                        self.delegate?.didGetSeries(series: serie.data)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(_ serieJSON: Data) -> AnimesListData? {
        
        let decoder = JSONDecoder()
        
        do {
            let animeData = try decoder.decode(AnimesListData.self, from: serieJSON)
            
            return animeData
            
        } catch {
            
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
