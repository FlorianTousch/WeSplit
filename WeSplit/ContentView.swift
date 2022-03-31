//
//  ContentView.swift
//  WeSplit
//
//  Created by Florian on 30/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipsPercentage = 20
    @FocusState private var isFocused: Bool

    var totalAmount: Double {
        let tipsAmount = Double(tipsPercentage * 5)
        let tipValue = checkAmount / 100 * tipsAmount
        return checkAmount + tipValue
    }

    var totalAmountPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return totalAmount / peopleCount
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) peoples")
                        }
                    }
                } header: {
                    Text("How much is the bill?")
                }

                Section {
                    Picker("Tip percentage", selection: $tipsPercentage) {
                        ForEach(0...20, id: \.self) {
                            Text($0 * 5, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("How much tips do you want to leave ?")
                }

                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                } header: {
                    Text("Total amount")
                }

                Section {
                    Text(totalAmountPerPerson, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
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
