//
//  ContentView.swift
//  WeSplit
//
//  Created by Alex Smith on 4/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocued: Bool
    let tipPercentages = (0...100)
    
    var totalPerPerson: Double {
        let PeopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = tipValue + checkAmount
        let amountPerPerson = grandTotal / PeopleCount
        
        return amountPerPerson
    }
    
    var totalTip: Double {
        let doubledTipPercentage = Double(tipPercentage)
        let finalTip = doubledTipPercentage / 100 * checkAmount
        return finalTip
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocued)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                                .toolbar {
                                    ToolbarItem(placement: .keyboard) {
                                        Button("Done") {
                                            amountIsFocued = false
                                        }
                                    }
                                }
                        }
                    }
                }
                
                Section {
                    NavigationLink {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.wheel)
                    } label: {
                        Text("Tip")
                    }
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(checkAmount + totalTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Your Bill")
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}


struct ContentViewPreview: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}
