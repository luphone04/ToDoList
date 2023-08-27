//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Lu Maw on 27/08/2023.
//

import SwiftUI

/*
 MVVM Architecture
 
 Model - datapoint
 View - UI
 ViewModel - manages Models for View
 
 */

@main
struct ToDoListApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    var body: some Scene {
        WindowGroup {
            //ContentView()
            ///all our view within the app is in the "Navigation View"
            NavigationView{
                ListView()
            }
            ///for Ipad I guess
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}
