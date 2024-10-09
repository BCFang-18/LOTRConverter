//
//  ContentView.swift
//  LOTRConverter17
//
//  Created by Baicheng Fang on 4/23/24.
//

import SwiftUI
import TipKit

struct ContentView: View {

//    var leftImage: ImageResource = .goldpenny
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @State var leftCurrency: Currency = Currency(rawValue: UserDefaults.standard.double(forKey: "leftCurrency")) ?? .silverPiece
    @State var rightCurrency: Currency = Currency(rawValue: UserDefaults.standard.double(forKey: "rightCurrency")) ?? .goldPiece

    private func saveCurrencies() {
        UserDefaults.standard.set(leftCurrency.rawValue, forKey: "leftCurrency")
        UserDefaults.standard.set(rightCurrency.rawValue, forKey: "rightCurrency")
    }
    
//    private func endEditing() {
//            UIApplication.shared.endEditing()
//        }
    
    var body: some View {
        ZStack{
            // background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                // prancing pony image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // currency exchange txt
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                // currency conversion section
                HStack{
                    // left conversion section
                    ConvertCurrencyView(leftCurrency: leftCurrency, showSelectCurrency: $showSelectCurrency, leftAmount: $leftAmount)
                        .focused($leftTyping)
                    
                    // equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)  // Tho Image, sf symbols can
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    // right conversion section
                    ConvertCurrencyView(leftCurrency: rightCurrency, showSelectCurrency: $showSelectCurrency, leftAmount: $rightAmount)
                        .focused($rightTyping)
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                
                Spacer()
                
                // info button
                HStack {
                    Spacer()
                    Button {
                        showExchangeInfo.toggle()
                        print("showExchangeInfo value:\(showExchangeInfo)")
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
//                    .sheet(isPresented: $showExchangeInfo){
//                        ExchangeInfo()
//                    }
                }
            }
//            .border(.blue)
        }
        .task {  // allow to run code in the background
            try? Tips.configure()
        }
        .onChange(of: leftAmount){
            if leftTyping{
                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightAmount) {  // this onChange is actually not connected to TextField, instead, the whole view, i.e. ContentView
            if rightTyping{
                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
            }
        }
        .onChange(of: leftCurrency){
            saveCurrencies()
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: rightCurrency){
            saveCurrencies()
            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
        }
        .sheet(isPresented: $showExchangeInfo){  // sheet doesnt have to be put after button, because sheet is activated only when the bindling variable, i.e. $showExchangeInfo is changed, no matter who changes that
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(topCurrency: $leftCurrency,
                           bottomCurrency: $rightCurrency)
        }
    }
    

}

#Preview {
    ContentView()
}

