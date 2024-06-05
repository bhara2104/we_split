//
//  ContentView.swift
//  we split
//
//  Created by Bharath on 05/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var totalAmount = 0.0
    @State private var totalPeople = 2
    @State private var tip = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercent = [10 ,20 ,30 ,40 ,50]
    var totalPerPerson: Double {
        let peopleCount = Double(totalPeople + 2)
        let tipSelection = Double(tip)
        let tipValue = totalAmount / 100 * tipSelection
        let grandTotal = totalAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter the totalAmount", value: $totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)
                }
                Section {
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                Section {
                    Picker("Select Number of People", selection: $totalPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How Much You Wanna Tip?") {
                    
                    Picker("Select The Tip", selection: $tip){
                        ForEach(tipPercent, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
            }.navigationTitle("We Split")
                .toolbar{
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}

