//
//  AddItemView.swift
//  CoreDataMigrations
//
//  Created by Karina gurachevskaya on 22.09.22.
//

import SwiftUI

struct AddItemView: View {
    
    var persistenceService = PersistenseService.shared
    
    @State private var itemName: String = ""
    @State private var amount: String = ""

    @Binding var isAddItemPresented: Bool
    
    var body: some View {
        VStack {
            TextField("Type name", text: $itemName)
                .padding()
                .frame(height: 50)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
            
            TextField("Amount", text: $amount)
                .keyboardType(.decimalPad)
                .padding()
                .frame(height: 50)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)

            Button {
                do {
                    try persistenceService.addItem(title: itemName, amount: Double(amount) ?? 1)
                    isAddItemPresented = false
                } catch let error {
                    print(error.localizedDescription)
                }
            } label: {
                Text("Add item")
                    .frame(height: 50)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(itemName.isEmpty)
        }
        .padding()
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(isAddItemPresented: .constant(false))
    }
}
