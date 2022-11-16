//
//  DictionaryData.swift
//  CityOfKardia
//
//  Created by Vincensa Regina on 16/11/22.
//

import Foundation

//enum Dictionary: String {
//    case penggumpalan_darah = "Penggumpalan Darah"
//    case sel_darah_putih = "Sel Darah Putih"
//
//    init(key: String) {
//        switch key {
//        case :
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
//
//}

public func getDictionaryItem(key: String) -> String {
    var value = ""
    switch key {
    case "penggumpalan_darah":
        value = "Penggumpalan Darah"
    case "sel_darah_putih":
        value = "Sel Darah Putih"
    default: break
    }
    return value
}
