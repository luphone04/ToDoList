//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Lu Maw on 27/08/2023.
//

import Foundation
/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 */

class ListViewModel: ObservableObject{
    @Published var items: [ItemModel] = []{
        ///anytime we change the items array, the function in "didSet" will get called
        didSet{
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    init(){
        getItems()
    }
    
    func getItems(){
//        let newItems = [
//            ItemModel(title: "This is the first title!", isCompleted: false),
//            ItemModel(title: "This is the second", isCompleted: true),
//            ItemModel(title: "Third!", isCompleted: false)
//        ]
//        items.append(contentsOf: newItems)
        ///try to run the data and fetch the key from :itemsKey"
        ///if ture, it gonna run all this code, else it will "run out of the function that's bcuz we need this data to move forward"
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else{
            return
        }
        
        self.items = savedItems

    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel){
        
        ///return a case where 'existingItem" Id is same as the passing ID
//        if let index = items.firstIndex{(existingItem) -> Bool in
//            return existingItem.id == item.id
//        }{
//            //run this code(if let)
//        }
        
        if let index = items.firstIndex(where: {$0.id == item.id}){
            items[index] = item.updateCompletion()
        }
    }
    
    //In class, it is better to use "user default"
    func saveItems(){
        ///turn item model into json data
        ///"try" JSONEncoder().encode(items) -->code things into JSON encoder
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
