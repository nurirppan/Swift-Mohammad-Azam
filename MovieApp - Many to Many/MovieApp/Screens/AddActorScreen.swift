//
//  AddActorScreen.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/11/21.
//

import SwiftUI

struct AddActorScreen: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
            Form {
                VStack(alignment: .leading) {
                    Text("Add Actor")
                        .font(.largeTitle)
                    Text("Lord of the Rings")
                }.padding(.bottom, 50)
                //TextField("Enter name", text: $addActorVM.name)
                HStack {
                    Spacer()
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button("Save") {
                        
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
    }
}

struct AddActorScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddActorScreen()
    }
}
