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

///When the data in an ObservableObject changes, the associated views can automatically update to reflect those changes.
///make an object observable, which means it can be used to publish changes to its properties.
class ListViewModel: ObservableObject{
    
    //a list called "items" model with "ItemModel"
    @Published var items: [ItemModel] = []{
        
        ///anytime we change the items array, the function in "didSet" will get called
        didSet{
            saveItems()
        }
    }
    
    /// implies that you are overwriting any previously saved data with each new data set. In other words, if you save data with the key "items_list" multiple times, the previously saved data under that key will be replaced by the most recent data.
    let itemsKey: String = "items_list"
    
    
    ///main working part after calling this item.
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
        ///
        ///will try to run functions inside guard,. If they are "nil", go to else.
        guard
            
            //retrieve the "item" data using the key "itemsKey"
            let data = UserDefaults.standard.data(forKey: itemsKey),
            
            //try to save it into "savedItems" using the item in"data"
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else{
            
            //stop the function
            return
        }
        
        //put the "savedItem" into model "items"
        
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
    
    
    ///list "item" with type "ItemModel"
    func updateItem(item: ItemModel){
        
        ///return a case where 'existingItem" Id is same as the passing ID
//        if let index = items.firstIndex{(existingItem) -> Bool in
//            return existingItem.id == item.id
//        }{
//            //run this code(if let)
//        }
        
        
        /// a method available on Swift arrays that searches for the first element in the array that satisfies a given condition.
        /// basically th
        if let index = items.firstIndex(where: {$0.id == item.id}){ //This code will execute because optionalValue is not nil
            
            items[index] = item.updateCompletion()
        }
    }
    
    //In class, it is better to use "user default"
    //this functions is to saved to "UserDefaults"
    func saveItems(){
        ///turn item model into json data
        ///"try" JSONEncoder().encode(items) -->code things into JSON encoder
        ///encodedData is JSON DATA to be stored in UserDeafults. by using a key "itemsKey"(can be used for later retrival)
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
