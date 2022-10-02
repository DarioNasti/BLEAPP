//
//  Peripheral.swift
//  BLEScanner
//
//  Created by DarioNasti on 02/10/22.
//

import Foundation

struct Peripheral : Identifiable {
    let id = UUID()
    let name : String
    let RSSI : Int
}

