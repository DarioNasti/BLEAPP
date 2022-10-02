//
//  BLEManager.swift
//  BLEScanner
//
//  Created by DarioNasti on 02/10/22.
//

import Foundation
import CoreBluetooth
import SwiftUI

class BLEManager : NSObject, ObservableObject, CBCentralManagerDelegate
{
   
    var centralManager : CBCentralManager?
    @Published var isSwitched = false
//    @Published var peripheralsStore = [Peripheral]()
    @Published var peripherals : [CBPeripheral] = []
    @Published var peripheralNames : [String] = []
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        centralManager?.delegate = self
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isSwitched = true
            central.scanForPeripherals(withServices: nil, options: nil)
        }
        else {
            isSwitched = false
        }
    }
    
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//
//        var peripheralName : String?
//        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
//            peripheralName = name
//        } else {
//            peripheralName = "Unknown"
//        }
//        let newPeripheral = Peripheral(name: peripheralName!, RSSI: RSSI.intValue)
//        print(newPeripheral)
//        peripheralsStore.append(newPeripheral)
//    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if !peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "Unknown")
        }
    
    }
    
    
    
    func startScanning() {
        print("Start Scanning")
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func stopScanning(){
        print("Stop Scanning")
        centralManager?.stopScan()
        
    }
    
    func connect(peripheral : CBPeripheral) {
        print("Connecting with \(String(describing: peripheral.name))...")
        centralManager?.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connessione riuscita con \(String(describing: peripheral.name))")
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Connessione fallita")
        central.cancelPeripheralConnection(peripheral)
    }

    
}



