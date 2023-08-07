//
//  HistoryView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 29/07/2023.
//

import SwiftUI

enum HistoryOptions: String, CaseIterable, Identifiable {
    var id: Self { self }
    case sold, all, bought
}

struct HistoryView: View {

    @StateObject private var historyViewModel: HistoryViewModel

    init(dataService: any CoreDataManager) {
        _historyViewModel = StateObject(
            wrappedValue:
                HistoryViewModel(
                    dataService: dataService
                )
        )
    }

    var body: some View {
        ZStack {
            Color.backgroundColor()
                .ignoresSafeArea()
            VStack {
                Picker("History", selection: $historyViewModel.historyPickerSelection) {
                    ForEach(HistoryOptions.allCases) { option in
                        Text(option.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                List {
                    ForEach(historyViewModel.shownProducts, id: \.self) { product in
                        HStack {
                            Text(product.name ?? "")
                                .font(.subheadline)
                            Spacer()
                            VStack(spacing: 10) {
                                Text(historyViewModel.getDate(for: product))
                                    .font(.subheadline)
                                if product.isSold {
                                    Text("\(product.soldPrice.asPrice())")
                                        .font(.subheadline)
                                } else {
                                    Text("\((-10).asPrice())")
                                        .font(.subheadline)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .foregroundStyle(Color.foregroundColor())
                    }
                }
                .listStyle(.plain)
                .listRowBackground(Color.backgroundColor())
            }
        }
    }
}
