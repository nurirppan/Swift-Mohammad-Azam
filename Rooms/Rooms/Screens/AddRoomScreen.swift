//
//  ContentView.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/23/21.
//

import SwiftUI

struct AddRoomScreen: View {
    
    @Environment(\.presentationMode) var presentation
    @StateObject var viewModel = AddRoomViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Enter room", text: $viewModel.name)
                    TextField("Enter width", text: $viewModel.width)
                    TextField("Enter length", text: $viewModel.length)
                    ColorPicker("Select color", selection: $viewModel.color)
                    
                    HStack {
                        Spacer()
                        Button("Save") {
                            self.viewModel.saveRoom()
                            presentation.wrappedValue.dismiss()
                        }
                        Spacer()
                    }

                }
            }
            .navigationTitle("Add Room")
        }
    }
}

struct AddRoomScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddRoomScreen()
    }
}
