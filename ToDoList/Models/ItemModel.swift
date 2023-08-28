//
//  ItemModel.swift
//  ToDoList
//
//  Created by Lu Maw on 27/08/2023.
//

import Foundation

//Immutable Struct
struct ItemModel: Identifiable, Codable{
    let id: String
    var title: String //mutable
    let isCompleted: Bool
    
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool){
        self.id = UUID().uuidString
        
        self.title = title
        self.isCompleted = isCompleted

    }
    
    func updateCompletion() -> ItemModel{
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
