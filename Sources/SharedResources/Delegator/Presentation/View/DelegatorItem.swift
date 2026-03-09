//
//  DelegatorItem.swift
//  CERQEL
//
//  Created by Youxel on 09/05/2024.
//  Copyright © 2024 Youxel. All rights reserved.
//

import SwiftUI

public struct DelegatorItem: View {
    var delegator : UserEntity
    var isSingleSelection: Bool
    var onSelect: ((Bool,String) -> ())?
    
    public init(delegator: UserEntity, isSingleSelection: Bool, onSelect: ((Bool, String) -> Void)? = nil) {
        self.delegator = delegator
        self.isSingleSelection = isSingleSelection
        self.onSelect = onSelect
    }
    
    public var body: some View {
        VStack{
            Button(action: {
                print("button pressed")
                onSelect?(delegator.isSelected,delegator.id!)
            }){
                HStack{
                    AsyncImage(url: URL(string: delegator.photo ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 36, height: 36)
                    .clipShape(Circle()).padding(.horizontal , 16)
                    Text(delegator.name ?? "_").font(CerqelFonts.bodyLRegular)
                        .foregroundColor(FormBuilderColors.typographyTitle).padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)).frame(maxWidth: .infinity, alignment: .leading)
                    isSingleSelection ? nil :
                    Image(delegator.isSelected ? "clostAlert" : "plusToAdd")
                        .renderingMode(.original).padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 16))
                    
                }
            }
            Divider()
        }.background(delegator.isSelected ? Color(primaryLight) : FormBuilderColors.white)
        
    }
}


