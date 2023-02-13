//
//  AppView.swift
//  AM5
//
//  Created by HoSeon Chu on 2023/02/13.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        // MARK: - PROPERTIES
        
        // MARK: - BODY
        TabView {
            PostView()
                .tabItem({
                    Image(systemName: "clock.circle")
                    Text("AM5")
                })
                .toolbarBackground(.visible, for: .tabBar)
            
            TaskListView()
                .tabItem({
                    Image(systemName: "gear")
                    Text("Setting")
                })
                .toolbarBackground(.visible, for: .tabBar)
        }//: TABVIEW
        .edgesIgnoringSafeArea(.top)
        .tint(Color.primary)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
