//
//  SettingsView.swift
//  AM5
//
//  Created by HoSeon Chu on 2023/02/13.
//

import SwiftUI

struct SettingsView: View {
    @State private var enableNotification: Bool = false
    @State private var backgroundRefresh: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .center, spacing: 5) {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text("User")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGreenAdaptive"))
            }//: VSTACK
            .padding()
            
            Form {
                // MARK: - SECTION1
                Section(header: Text("기본 설정")) {
                    Toggle(isOn: $enableNotification) {
                        Text("Enable Notification")
                    }
                    
                    Toggle(isOn: $backgroundRefresh) {
                        Text("Background Refresh")
                    }
                }
            
                // MARK: - SECTION2
                Section(header: Text("사용자 설정")) {
                    if enableNotification {
                        HStack {
                            Text("Product").foregroundColor(Color.gray)
                            Spacer()
                            Text("Avocado Recipes")
                        }
                    }
                }
                
                
            }
        }//: VSTACK
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
