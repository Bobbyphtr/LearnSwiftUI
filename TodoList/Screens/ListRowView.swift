//
//  ListRowView.swift
//  TodoList
//
//  Created by Bobby Pehtrus on 01/08/22.
//

import SwiftUI

struct ListRowView: View {
    
    let todo: Todo
    
    var body: some View {
        HStack {
            if todo.isCompleted {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(Color.green)
            } else {
                Image(systemName: "circle")
                    .foregroundColor(Color.red)
            }
            Text(todo.title)
            Spacer()
        }
    }
}


struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(todo: Todo(title: "Todo is not completed", isCompleted: false))
            .previewLayout(.sizeThatFits)
        ListRowView(todo: Todo(title: "Todo is completed", isCompleted: true))
            .previewLayout(.sizeThatFits)
    }
}
