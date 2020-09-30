//
//  GridsViewModel.swift
//  SwiftUI Grids With Search
//
//  Created by Ahmed Serdah on 29/09/2020.
//
import SwiftUI

class GridsViewModel: ObservableObject {
    @Published var results = [ResultModel]()
    
    init() {
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/50/explicit.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            
            guard let data = data else{
                return
            }
            
            do{
                let rss = try JSONDecoder().decode(RssModel.self ,from:data)
                DispatchQueue.main.async {
                    self.results = rss.feed.results
                }
            }
            catch{
                print("Error" ,error.localizedDescription)
            }
            
        }.resume()
        
        
    }
    
}
