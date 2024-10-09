//
//  SelectCurrency.swift
//  LOTRConverter17
//
//  Created by Baicheng Fang on 4/26/24.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var topCurrency: Currency  // sometime swift knows the type once you assign a
    @Binding var bottomCurrency: Currency // for binding, you do not get to decide your value
    
    
    var body: some View {
        ZStack{
            // parchment background iamge
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack{
                // text
                Text("Select the currency you are starting with:")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                // currency icons
                IconGrid(currency: $topCurrency)
                
                // text
                Text("Select the currency you would like to convert to:")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                // currency icons
                IconGrid(currency: $bottomCurrency)
                
                // done button
                Button("Done"){
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SelectCurrency(topCurrency: .constant(.copperPenny), bottomCurrency: .constant(.silverPiece))
}
