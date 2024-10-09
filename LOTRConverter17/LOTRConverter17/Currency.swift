//
//  Currency.swift
//  LOTRConverter17
//
//  Created by Baicheng Fang on 4/26/24.
//

import SwiftUI


enum Currency: Double, CaseIterable, Identifiable {  // use caseIterable to turn enum into an array so that ForEach can access
    case copperPenny = 1024
    case copperPiece = 256
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    var id: Currency { self }
    
    var image: ImageResource{  // computed property
        switch self {
        case .copperPenny:
                .copperpenny
        case .copperPiece:
                .copperpiece
        case .silverPenny:
                .silverpenny
        case .silverPiece:
                .silverpiece
        case .goldPenny:
                .goldpenny
        case .goldPiece:
                .goldpiece
            
        }
    }
    
    var name: String{
        switch self {
        case .copperPenny:
            "Copper Penny"
        case .silverPenny:
            "Silver Penny"
        case .silverPiece:
            "Silver Piece"
        case .goldPenny:
            "Gold Penny"
        case .goldPiece:
            "Gold Piece"
        case .copperPiece:
            "Copper Piece"
        }
    }
    
    func convert(_ amountString: String, to currency: Currency) -> String{
        guard let doubleAmount = Double(amountString)  // we have to think all cases where users may type letters other than number (use guard)
        else{
            return ""
        }
        
        let convertedAmount = (doubleAmount / self.rawValue) * currency.rawValue
        
        return String(format: "%.2f", convertedAmount)
    }
}
