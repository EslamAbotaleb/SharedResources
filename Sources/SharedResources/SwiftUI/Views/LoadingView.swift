//
//  LoadingView.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import SwiftUI

public struct LoadingView: View {
    public init() {}
    public var body: some View {
        ZStack (alignment: .top ) {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.vertical)
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
