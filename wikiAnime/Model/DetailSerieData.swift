//
//  DetailSerieData.swift
//  wikiAnime
//
//  Created by Sebas's Mac on 29/11/22.
//

import Foundation

struct DetailSerieData: Codable {

    let data: Serie
}

struct Serie: Codable{
    
    let attributes: DetailAttributes
}

struct DetailAttributes: Codable{

    let synopsis: String?
    let canonicalTitle: String?
    let startDate: String?
    let endDate: String?
    let nextRelease: String?
    let status: String?
    let episodeCount: Int?
    let episodeLength: Int?
    let coverImage: CoverImage?
    let posterImage: PosterImg?
}

struct CoverImage: Codable {

    let original: String?
}

struct PosterImg: Codable {
    
    let tiny: String?
}
