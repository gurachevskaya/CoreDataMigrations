//
//  ContentView.swift
//  CoreDataMigrations
//
//  Created by Karina gurachevskaya on 21.09.22.
//

import SwiftUI

struct GroceriesView: View {
    
    @StateObject private var persistenceService = PersistenseService.shared
    
    @FetchRequest(
        entity: GroceryItem.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \GroceryItem.title, ascending: true)
        ]) var items: FetchedResults<GroceryItem>
    
    @State private var isAddItemPresented = false
    
    var body: some View {
        VStack {
            Text("Groceries list")
                .font(.title)
            
            Button {
                isAddItemPresented = true
            } label: {
                Image(systemName: "plus.circle")
                    .frame(height: 50)
            }
            
            List {
                ForEach(items) { item in
                    HStack {
                        Text(item.title ?? "unknown")
                        Spacer()
                        Text(String(format: "%.1f", item.amount))
                    }
                }
                .onDelete(perform: deleteItem)
            }
        }
        .padding()
        .sheet(isPresented: $isAddItemPresented) {
            AddItemView(isAddItemPresented: $isAddItemPresented)
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let item = items[index]
            do {
                try persistenceService.deleteItem(item)
            } catch let error {
                print(error)
            }
        }
    }
}

struct GroceriesView_Previews: PreviewProvider {
    static var previews: some View {
        GroceriesView()
    }
}
