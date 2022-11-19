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
    case "sel_darah_merah" : value = "Sel Darah Merah"
    case "serambi_kanan" : value = "Serambi Kanan"
    case "gate_serambi_kanan" : value = "Gate Serambi Kanan"
    case "bilik_kanan" : value = "Bilik Kanan"
    case "sel_darah_putih" : value = "Sel Darah Putih"
    case "jantung" : value = "Jantung"
    case "peredaran_darah_kecil" : value = "Peredaran Darah Keci"
    case "peredaran_darah_besar" : value = "Peredaran Darah Besar"
    case "arteri_pulmonalis" : value = "Arteri Pulmonalis"
    case "penggumpalan_darah" : value = "Penggumpalan Darah"
    case "kapiler" : value = "Kapiler"
    case "paru_paru" : value = "Paru-Paru"
    case "alveolus" : value = "Alveolus"
    default: break
    }
    return value
}
