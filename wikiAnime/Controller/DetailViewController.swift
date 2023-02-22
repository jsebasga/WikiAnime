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
        
        //TODOS
        // 1. Crear objeto clase DetailSerieData
        // 2. Llenar los campos del objetos (Dummie)
        
        let coverImage: CoverImage = CoverImage(
            original: "https://media.kitsu.io/anime/12/cover_image/21ecb556255bd46b95aea4779d19789f.jpg")
        
        let detailAttributes: DetailAttributes = DetailAttributes(
            synopsis: "Gol D. Roger was known as the \"Pirate King,\" the strongest and most infamous being to have sailed the Grand Line. The capture and death of Roger by the World Government brought a change throughout the world. His last words before his death revealed the existence of the greatest treasure in the world, One Piece. It was this revelation that brought about the Grand Age of Pirates, men who dreamed of finding One Piece—which promises an unlimited amount of riches and fame—and quite possibly the pinnacle of glory and the title of the Pirate King.\nEnter Monkey D. Luffy, a 17-year-old boy who defies your standard definition of a pirate. Rather than the popular persona of a wicked, hardened, toothless pirate ransacking villages for fun, Luffy’s reason for being a pirate is one of pure wonder: the thought of an exciting adventure that leads him to intriguing people and ultimately, the promised treasure. Following in the footsteps of his childhood hero, Luffy and his crew travel across the Grand Line, experiencing crazy adventures, unveiling dark mysteries and battling strong enemies, all in order to reach the most coveted of all fortunes—One Piece.\n[Written by MAL Rewrite]",
            canonicalTitle: "One Piece",
            startDate: "20-10-1999",
            endDate: "No se sabe",
            nextRelease: "El Domingo",
            status: "En emision",
            episodeCount: 1024,
            episodeLength: 25,
            coverImage: coverImage)
        
        let serie: Serie = Serie(
            attributes: detailAttributes)
        
        let detailSerieData: DetailSerieData = DetailSerieData(
            data: serie)
        
        // 3. Crear diseño de vista
        
        // 4. Mostrar los datos del Dummie en la vista
        
        
        coverImageOriginal.loadFrom(URLAddress: "https://media.kitsu.io/anime/12/cover_image/21ecb556255bd46b95aea4779d19789f.jpg")
        
        title = detailSerieData.data.attributes.canonicalTitle
        startDate.text = detailSerieData.data.attributes.startDate
        endDate.text = detailSerieData.data.attributes.endDate
        serieStatus.text = detailSerieData.data.attributes.status
        nextRelease.text = detailSerieData.data.attributes.nextRelease
        numberEpisode.text = "1024 Espisodes"
        duration.text = "25 minutes"
        serieDescription.text = detailSerieData.data.attributes.synopsis
        
    }
    
}
