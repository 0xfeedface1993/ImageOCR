//
//  ContentView.swift
//  Demo
//
//  Created by john on 2023/9/11.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = ImageConvertModel()
    
    var body: some View {
        VStack {
            if let image = model.image {
                Image(image, scale: 1.0, label: Text("test"))
            }   else    {
                Text("No Image")
            }
            
            Button {
                model.scale()
            } label: {
                Text("scale 2x")
            }

            Button {
                
            } label: {
                Text("threshold")
            }
        }
        .padding()
        .task {
            try? await model.reloadImage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
