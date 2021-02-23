//
//  ContentView.swift
//  MLFormatHelper
//
//  Created by Choong Han Soong on 23/2/21.
//

import SwiftUI

struct ContentView: View {
    @State var filePath = "File Name"
    let toJson = ToJson()
    var body: some View {
        VStack {
            HStack {
                Text(filePath).scaledToFit()
                Button(
                    action: {
                        filePath = openPanel()
                    }, label: {
                        Text("Open File")
                    }
                )
            }
            Button(
                action: {
                    toJson.vottJsonToCreateMLJson(filePath)
                    
                } ,
                label: {
                    Text("Convert")
                }
            )
        }
        .frame(minWidth:400)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
