//
//  ContentView.swift
//  SwiftyAlerts
//
//  Created by Robert Harrison on 2/11/22.
//

import SwiftUI

struct ContentView: View {
    
    enum AlertItem: Hashable, Identifiable {
        case general(String, String)
        case delete
        case settings
        
        var id: Int { return hashValue }
    }
    
    @State private var alertItem: AlertItem?
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    
                    Button {
                        alertItem = .general("Error", "Uh oh! Something went wrong!")
                    } label: {
                        Text("Show Alert")
                            .font(.system(size: 24))
                            .fontWeight(.medium)
                            .padding()
                            .foregroundColor(.blue)
                    }
                    
                    Button {
                        alertItem = .delete
                    } label: {
                        Text("Show Destructive")
                            .font(.system(size: 24))
                            .fontWeight(.medium)
                            .padding()
                            .foregroundColor(.red)
                    }

                    Button {
                        alertItem = .settings
                    } label: {
                        Text("Show Settings")
                            .font(.system(size: 24))
                            .fontWeight(.medium)
                            .padding()
                            .foregroundColor(.green)
                    }
                    
                } // VStack
                
            } // ZStack
            
            .alert(item: $alertItem) { alertItem in
                switch alertItem {
                    
                case .general(let title, let message):
                    return Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("OK")))
                    
                case .delete:
                
                    return Alert(
                        title: Text("Delete Item"),
                        message: Text("Are you sure you want to delete the item?"),
                        primaryButton: .destructive(Text("Yes, Delete Item"), action: { print("Delete Item") }),
                        secondaryButton: .default(Text("Cancel"), action: {})
                    )
                    
                case .settings:
                    return Alert(
                        title: Text("Location Settings"),
                        message: Text("Location permissions are required to use this feature. Please allow access to Location in the Settings app."),
                        primaryButton: .cancel(Text("Cancel"), action: {}),
                        secondaryButton: .default(Text("Settings"), action: {
                    
                            guard let settings = URL(string: UIApplication.openSettingsURLString),
                                  UIApplication.shared.canOpenURL(settings) else {
                                return
                            }
                            UIApplication.shared.open(settings)
                        })
                    )
                    
                }
            } // alert
            
            .navigationBarTitle("SwiftyAlerts")
            .navigationBarTitleDisplayMode(.inline)
            
        } // NavigationView
        
    } // body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
