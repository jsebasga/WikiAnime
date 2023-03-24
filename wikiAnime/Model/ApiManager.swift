//
//  SerieManager.swift
//  wikiAnime
//
//  Created by Sebastian Güiza on 2/11/22.
//

import Foundation
import Alamofire

struct ApiManager {
    
    let animesListURL = "https://kitsu.io/api/edge/anime"
    
    private let kStatusOk = 200...299
    
    func getAnimeListBySearch(animeName: String,
                      success: @escaping (_ animeData:AnimesListData) -> (),
                              failure: @escaping(_ error: Error?) -> ()) {
        
        let url = "\(animesListURL)?filter[text]=\(animeName)"
        print("******\(url)")
        
        AF.request(url, method: .get)
            .validate(statusCode: kStatusOk)
            .responseDecodable (of: AnimesListData.self) { response in
                
                if let anime = response.value {
                    print("******\(anime)")
                    success(anime)
                }
                
                if let responseError = response.error {
                    print("******\(responseError)")
                    failure(response.error)
                }
            }
    }
    
    func getAnimesList(success: @escaping (_ animeData:AnimesListData) -> (),
                       failure: @escaping(_ error: Error?) -> ()) {
        
        let url = animesListURL
        
        AF.request(url, method: .get)
            .validate(statusCode: kStatusOk)
            .responseDecodable (of: AnimesListData.self) { response in
                
                if let anime = response.value {
                    success(anime)
                }
                
                if let responseError = response.error {
                    failure(response.error)
                }
            }
    }
    
    func getAnimeSerie(serieId: String,
                       success: @escaping(_ serieData:DetailSerieData) -> (),
                       failure: @escaping(_ error: Error?) -> ()) {
        
        let serieURL = "\(animesListURL)/\(serieId)"
        print(serieURL)
        
        AF.request(serieURL, method: .get)
            .validate(statusCode: kStatusOk)
            .responseDecodable (of: DetailSerieData.self) { response in
                
                if let serie = response.value {
                    success(serie)
                }
                
                if let responseError = response.error {
                    failure(response.error)
                }
            }
    }
}
