//
//  ConvertCurrencyView.swift
//  LOTRConverter17
//
//  Created by Baicheng Fang on 4/28/24.
//

import SwiftUI

struct ConvertCurrencyView: View {
    let leftCurrency: Currency
    @Binding var showSelectCurrency:Bool
    @Binding var leftAmount: String
    
    var body: some View {
        VStack{
            // currency
            HStack{
                // currency image
                Image(leftCurrency.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 33)
                
                // currency text
                Text(leftCurrency.name)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .padding(.bottom, -5)
            .onTapGesture {
                showSelectCurrency.toggle()
            }
            .popoverTip(CurrencyTip(), arrowEdge: .bottom)
            
            // textfield
            TextField("Amount", text: $leftAmount)  // without $, only programmers can change value of this string; with $, users can change
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
//                .focused($leftTyping)  // if I'm not focused, aka user is not typing me, do not onChange me
            
        }
    }
}

//#Preview {
//    ConvertCurrencyView(leftCurrency: <#Currency#>, showSelectCurrency: <#Binding<Bool>#>, leftAmount: <#Binding<String>#>)
//}
