//
//  GridsView.swift
//  SwiftUI Grids With Search
//
//  Created by Ahmed Serdah on 29/09/2020.
//

import SwiftUI
import KingfisherSwiftUI

struct GridsView: View {
    @ObservedObject var vm = GridsViewModel()
    @State var searchText = ""
    @State var isSearching = false
    var body: some View {
        
        NavigationView{
            
            ScrollView{
                HStack{
                HStack{
                    
                    TextField("Search Item", text: $searchText)
                    .padding(.leading ,24)

                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(6)
                .padding(.horizontal,20)
                .onTapGesture(perform: {
                    isSearching = true
                })
                .overlay(
                    HStack{
    
                        Image(systemName:"magnifyingglass")
                        Spacer()
                        if isSearching || searchText.isEmpty == false {
                            Button(action: {
                                searchText = ""
                                isSearching = false
                                
                            }, label: {
                                Image(systemName:"xmark.circle.fill")
                            })
                        }
                        
                    }
                    .padding(.horizontal,32)
                    .foregroundColor(.gray)
                )
                    if isSearching || searchText.isEmpty == false{
                    Button(action: {
                        searchText = ""
                        isSearching = false
                        
                    }, label: {
                        Text("Cancel")
                    })
                    .padding(.trailing,20)
                    }
                    
                }
                
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 50, maximum: 200),spacing: 16,alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200),spacing: 16,alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200),spacing: 16)
                ],alignment:.leading, spacing: 16,content:
                 
                    /*@START_MENU_TOKEN@*/{
                        ForEach(vm.results.filter({$0.name.contains(searchText)||searchText.isEmpty}),id:\.self) { app  in
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
