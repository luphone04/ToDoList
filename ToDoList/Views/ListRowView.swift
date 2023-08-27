//
//  ListRowView.swift
//  ToDoList
//
//  Created by Lu Maw on 27/08/2023.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green: .red)
            Text(item.title)
            Spacer()///make sure they are put to the left
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    ///static mean they will not change
    ///
    static var item1 = ItemModel(title: "Finish Item!", isCompleted: false)
    
    
    static var item2 = ItemModel(title: "Second Item", isCompleted: true)
    static var previews: some View {
        ///group so that it has two separate previews
        Group{
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
