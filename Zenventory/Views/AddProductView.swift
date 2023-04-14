//
//  AddProductView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 04/04/2023.
//

import SwiftUI
import PhotosUI


struct AddProductView: View {

    @StateObject private var vm = AddProductVModel()

    var body: some View {
        NavigationStack {
            ZStack {
                ZColor.background
                VStack(spacing: 20) {
                    PhotosPicker(selection: $vm.selectedItem, matching: .images, photoLibrary: .shared()) {
                        Image(uiImage: vm.productImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .foregroundColor(.gray)
                            .background(.clear)
                            .padding(.bottom, 50)
                    }
                    .onChange(of: vm.selectedItem) { _ in
                        print(vm.selectedItem)
                    }

                    VStack(spacing: 20) {
                        TextField("Name", text: $vm.productName)
                        TextField("Guarantee (months)", text: $vm.productGuarantee)
                        TextField("Care name (cleaning, insurance etc.)", text: $vm.productCareName)
                        TextField("Care interval", text: $vm.productCareInterval)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)

                    Text("Importance: " + String(Int(vm.importanceSlider)))
                    Slider(value: $vm.importanceSlider, in: 0...10, step: 1)
                        .padding(.horizontal)

                    NavigationLink("Receipt & invoice") {
                        AddProductView()
                    }

                    Button("Add product") { }
                        .buttonStyle(StandardButton())
                }
                .padding()
            }
            .ignoresSafeArea()
            .navigationTitle("Add product")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
