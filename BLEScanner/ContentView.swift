//
//  ContentView.swift
//  BLEScanner
//
//  Created by DarioNasti on 02/10/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var bleManager = BLEManager()
    
    var body: some View {
            VStack(spacing: 10){
//            Text("Bluetooth devices")
//                .font(.largeTitle)
//                .frame(alignment: .center)
                NavigationView {
                    List(bleManager.peripheralNames, id: \.self){ peripheral in
                        Text(peripheral)
                    }.navigationTitle("Bluetooth devices")
                }
                Spacer()
                Text("Status:")
                .font(.headline)
                if bleManager.isSwitched {
                    Text("Bluetooth is switched on")
                    .foregroundColor(.green)
                } else {
                    Text("Bluetooth is not switched on")
                    .foregroundColor(.red)
                }
                Spacer()
                HStack(spacing: 10){
                    VStack(spacing: 10){
                        Button(action: {self.bleManager.startScanning()
                        }) {
                            Text("Start scanning")
                        }
                        Button(action: {self.bleManager.stopScanning()
                        }) {
                            Text("Stop scanning")
                        }.padding()
                }
                    Spacer()
                    VStack(spacing: 10){
                        Button(action: {print("Start advertising...")
                    }) {
                        Text("Start advertising")
                    }
                        Button(action: {print("Stop advertising...")
                    }) {
                        Text("Stop advertising")
                    }.padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
