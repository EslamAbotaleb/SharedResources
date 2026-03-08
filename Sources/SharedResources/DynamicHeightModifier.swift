//
//  CalculateHeight.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import Foundation
import SwiftUI

public struct CalculateHeight: ViewModifier {
    @Binding var height: CGFloat
    
    public init(height: Binding<CGFloat>) {
        self._height = height
    }
    
    public func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            DispatchQueue.main.async {
                                height = proxy.size.height
                            }
                        }
                        .onChange(of: proxy.size.height) { newHeight in
                            DispatchQueue.main.async {
                                height = newHeight
                            }
                        }
                }
            )
    }
}
