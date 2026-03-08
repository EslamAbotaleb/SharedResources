//
//  CustomNavBar.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import SwiftUI
internal import EasyTipView

public struct CustomNavBar<Trailing: View>: View {

    let title : String?
    let trailing : Trailing?
    let onBack: (()->())?
    
    public init(title: String? = nil,
                trailing: Trailing? = nil,
                onBack: (() -> ())? = nil) {
        self.title = title
        self.trailing = trailing
        self.onBack = onBack
    }
    
    public var body: some View {
        VStack(){
            HStack{
                BackButton( onBack: { onBack!()})
                    .padding(.leading,14)
                    .frame(maxWidth: .infinity,alignment: .leading)

                Text(title ?? "")
                    .font(CerqelFonts.bodyLMedium)
                    .foregroundStyle(Color(uiColor: typographyTitle))
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    .frame(maxWidth: .infinity,alignment: .center)
                if let trailing = trailing {
                    trailing
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .padding(.trailing,14)
                }
            }
        }
        .background(Color(uiColor: bgHColor))
    }
}


#Preview {
    CustomNavBar(title: "Weather Details", trailing: Image("settings 6")) {
        
    }
}
