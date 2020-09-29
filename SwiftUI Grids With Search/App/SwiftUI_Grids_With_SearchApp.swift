//
//  SwiftUI_Grids_With_SearchApp.swift
//  SwiftUI Grids With Search
//
//  Created by Ahmed Serdah on 29/09/2020.
//

//Build out a Grid with multiple columns and consume JSON with ObservableObject view models.
//Furthermore, we'll load images using KingFisher for SwiftUI.
//SwiftUI doesn't seem to have a native search component for ScrollView type lists, so lets build one ourselves!


import SwiftUI

@main
struct SwiftUI_Grids_With_SearchApp: App {
    var body: some Scene {
        WindowGroup {
            GridsView()
        }
    }
}


