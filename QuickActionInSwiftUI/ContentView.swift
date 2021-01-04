//
//  ContentView.swift
//  QuickActionInSwiftUI
//
//  Created by ramil on 04.01.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var quickActionObservable: QuickActionObservable
    
    var body: some View {
        VStack {
            Text("Quick actions in SwifUI")
                .padding()
            
            if quickActionObservable.selectedAction?.title != nil {
                Text(quickActionObservable.selectedAction!.title)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
