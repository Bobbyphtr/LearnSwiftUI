//
//  ListView.swift
//  TodoList
//
//  Created by Bobby Pehtrus on 01/08/22.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }
            else {
                List {
                    ForEach(listViewModel.items, id: \.id) { item in
                        ListRowView(todo: item)
                            .onTapGesture {
                                withAnimation(
                                    .linear(duration: 0.2)
                                ) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Todo List 📒")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("Add", destination: AddView())
            }
        })
        // IOS 13 - 14
//        .navigationBarItems(
//            leading: EditButton(),
//            trailing:
//                NavigationLink("Add", destination: AddView())
//        )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}

