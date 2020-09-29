//
//  GridsView.swift
//  SwiftUI Grids With Search
//
//  Created by Ahmed Serdah on 29/09/2020.
//

import SwiftUI
import KingfisherSwiftUI
struct RssModel: Decodable {
    let feed : FeedModel
}

struct FeedModel: Decodable {
    let results : [ResultModel]
}

struct ResultModel: Decodable,Hashable {
    let name,releaseDate,artworkUrl100, copyright: String
}

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

struct GridsView: View {
    @ObservedObject var vm = GridsViewModel()
    var body: some View {
        
        NavigationView{
            
            ScrollView{
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 50, maximum: 200),spacing: 16,alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200),spacing: 16,alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200),spacing: 16)
                ],alignment:.leading, spacing: 16,content:
                    /*@START_MENU_TOKEN@*/{
                        ForEach(vm.results,id:\.self) { app  in
                            info(app: app)
                        }
                   
                    }/*@END_MENU_TOKEN@*/).padding(.horizontal,12)
                
            }
            .navigationTitle("Grid Search")
        }
        
    }
}

struct info: View {
    let app: ResultModel
    
    var body: some View {
        VStack(alignment: .leading , spacing: 4){
            KFImage(URL(string: app.artworkUrl100))
                .resizable()
                .scaledToFit()
                .cornerRadius(22)
            Text(app.name)
                .font(.system(size: 10, weight: .semibold))
                .padding(.top,4)
            Text(app.name)
                .font(.system(size: 9, weight: .regular))
            Text(app.name)
                .font(.system(size: 9, weight: .regular))
                .foregroundColor(.gray)
            Spacer()
        }
    }
    
}

struct GridsView_Previews: PreviewProvider {
    static var previews: some View {
        GridsView()
    }
}
