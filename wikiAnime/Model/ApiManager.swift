//
//  SerieManager.swift
//  wikiAnime
//
//  Created by Sebastian Güiza on 2/11/22.
//

import Foundation

protocol ApiManagerDelegate {
    
    func didGetSeries(series: [Anime])
    func didGetSerie(serie: Serie)
    func didFailWithError(error: Error)
}

struct ApiManager {
    
    let animesListURL = "https://kitsu.io/api/edge/anime/"
    
    var delegate: ApiManagerDelegate?
    
    func getAnimesList(){
        
        if let url = URL(string: animesListURL){
            
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
    
    func getAnimeSerie(serieId: String){
        
        let serieURL = "\(animesListURL)\(serieId)"
        print(serieURL)
        
        if let url = URL(string: serieURL){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if let safeError = error {
                    
                    self.delegate?.didFailWithError(error: safeError)
                    return
                }
                
                //Si data no es nulo, guarde el valor en safeData
                if let safeData = data {
                    
                    //Si no es nulo el parseSerieJSon (este transforma los datos de JSon a Swift), se guarda en la constante serie
                    if let serie:DetailSerieData = self.parseSerieJson(safeData){
                        
                        // Notificacion al delegado que ya esta el objeto serie
                        self.delegate?.didGetSerie(serie: serie.data)
                        
                        print(serie)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseSerieJson(_ serieJSON: Data) -> DetailSerieData? {
        
        let decoder = JSONDecoder()
        
        do {
            let animeData = try decoder.decode(DetailSerieData.self, from: serieJSON)
            
            return animeData
            
        } catch {
            
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
