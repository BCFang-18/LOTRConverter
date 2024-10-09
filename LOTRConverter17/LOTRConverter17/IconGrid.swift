//
//  IconGrid.swift
//  LOTRConverter17
//
//  Created by Baicheng Fang on 4/27/24.
//

import SwiftUI

struct IconGrid: View {
    @Binding var currency: Currency
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
            ForEach(Currency.allCases){ currency in  // '_' means we have accepted index numbers but we are not using it
                if self.currency == currency{
                    CurrencyIcon(currencyImage: currency.image, currencyName: currency.name)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .overlay {  // kind of ZStack
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .stroke(lineWidth: 3)
                                .opacity(0.5)
                        }
                } else{
                    CurrencyIcon(currencyImage: currency.image, currencyName: currency.name)
                        .onTapGesture {
                            self.currency = currency
                        }  // whenever user touches, the whole screen is refreshed, all views are re-displayed from scrath
                }
                // image is computed property, only known when using
            }
        }
    }
}

#Preview {
    IconGrid(currency: .constant(.silverPiece))
}
