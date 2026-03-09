//
//  SearchBarView.swift
//  SharedResources
//
//  Created by Omar Ibrahim on 3/5/26.
//


import SwiftUI

public struct SearchBarView : View {
    var hintText : String
    @Binding var text: String
    @State private var isEditing = false
    @FocusState private var isTextFieldFocused: Bool
    var onTextChanged: () -> Void
    
    public init(hintText: String, text: Binding<String>, onTextChanged: @escaping () -> Void) {
        self.hintText = hintText
        self._text = text
        self.onTextChanged = onTextChanged
    }
    
   public var body: some View {
        VStack(spacing : 0){
            HStack {
                Image("search-Bar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24,height: 24)
                    .foregroundStyle(Color(primaryMain))
                TextField(hintText, text: $text)
                    .focused($isTextFieldFocused)
                    .onChange(of: text) { newValue in
                        // Check if the TextField is focused to handle user-initiated changes
                        if isTextFieldFocused {
                            // Perform your logic here
                            print(newValue)
                            onTextChanged()
                        }
                    } .onTapGesture {
                        self.isEditing = true
                    }
            }
            .frame(height: 48)
            .padding(.horizontal,16)
            .background(FormBuilderColors.SupportSkyBlueLight)
            Divider()
                .padding(.horizontal,0)
                .shadow(color: .black.opacity(0.1), radius: 2.5, x: 0, y: 1)
        }
    }
}
