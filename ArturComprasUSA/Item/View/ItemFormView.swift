//
//  ItemFormView.swift
//  ArturComprasUSA
//
//  Created by Artur Cristiano Lansoni on 29/01/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ItemFormView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var item: Item
    @Binding var path: NavigationPath
    @State private var selectedPoster: PhotosPickerItem?
    @State private var posterImageData: Data?
    @State private var showAlert = false
    @State private var alertMessage = ""

    init(item: Item? = nil, path: Binding<NavigationPath>) {
        self.item = item ?? Item()
        self._path = path
    }

    var body: some View {
        VStack {
            form
            saveButton
        }
    }

    private var form: some View {
        Form {
            Section("Nome do produto *") {
                TextField("Nome", text: $item.name)
            }

            Section("Imposto do estado (%) *") {
                TextField("Imposto", value: $item.tax, format: .number)
            }

            Section("Valor do produto (U$) *") {
                TextField("Valor", value: $item.value, format: .number)
            }
            
            Section("Meio de pagamento") {
                Toggle("Pagou com cartão?", isOn: $item.isPurchasedWithCard)
            }

            Section("Foto *") {
                PhotosPicker(selection: $selectedPoster,
                             matching: .images) {
                    Label("Selecione a foto", systemImage: "photo" )
                }

                if let posterImageData,
                   let uiimage = UIImage(data: posterImageData) {
                    Image(uiImage: uiimage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

            }
        }
        .listSectionSpacing(3)
        .navigationTitle(item.name.isEmpty ? "Cadastro de produto" : item.name)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedPoster) {
            Task {
                posterImageData = try? await selectedPoster?.loadTransferable(type: Data.self)
                item.image = posterImageData
            }

        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Ops"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private var saveButton: some View {
        Button {
            if(validateForm()){
                modelContext.insert(item)
                path.removeLast()
            }
        } label: {
            Text("Cadastrar")
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .padding(16)
    }
    
    private func validateForm() -> Bool {
        if (item.name.isEmpty) {
            alertMessage = "O nome do produto é obrigatório."
            showAlert = true
            return false
        }
        if (item.tax?.isZero ?? true) {
            alertMessage = "O imposto do estado é obrigatório."
            showAlert = true
            return false
        }
        if (item.value?.isZero ?? true) {
            alertMessage = "O valor do produto é obrigatório."
            showAlert = true
            return false
        }
        if (item.image == nil){
            alertMessage = "A foto é obrigatória."
            showAlert = true
            return false
        }
        alertMessage = ""
        showAlert = false
        return true
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Item.self, configurations: configuration)
        let item = Item(name: "Shoes",
                        tax: 2.5,
                        value: 10.0,
                        isPurchasedWithCard: true,
                        picture: nil)

        return ItemFormView(item: item, path: .constant(NavigationPath()))
            .modelContainer(container)
    } catch {
        fatalError("Não consegui criar o Preview")
    }
}
