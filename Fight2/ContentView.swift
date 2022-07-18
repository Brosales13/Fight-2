//
//  ContentView.swift
//  Fight
//
//  Created by Brian Rosales on 5/25/22.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @EnvironmentObject var data: DataModel

    var body: some View {
        
        ZStack {
            if data.enableAR {ARDisplayView()}
            else {Spacer()}
            HStack {
                VStack {
                    Spacer()
                    ARUIView()
                }
            }
        }
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView() .environmentObject(DataModel())
           
    }
}
#endif
