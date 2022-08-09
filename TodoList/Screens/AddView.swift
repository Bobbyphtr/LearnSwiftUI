//
//  AddView.swift
//  TodoList
//
//  Created by Bobby Pehtrus on 01/08/22.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55.0)
                    .background(Color(white:0.95))
                .cornerRadius(10)
                
                Button(action:saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .frame(height: 55.0)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })

            }
            .padding(.horizontal)
        }
        .navigationTitle("Add an Item ✒️")
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text(alertTitle))
        })
    }
    
    private func saveButtonPressed() {
        if let errorText = validate() {
            alertTitle = errorText
            showAlert.toggle()
            return
        }
        // Validation is true
        listViewModel.addItems(title: textFieldText)
        presentationMode.wrappedValue.dismiss()
    }
    
    private func validate() -> String? {
        if textFieldText.count < 3 {
            return "Field should atleast 3 characters long!"
        }
        return nil
    }

}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
