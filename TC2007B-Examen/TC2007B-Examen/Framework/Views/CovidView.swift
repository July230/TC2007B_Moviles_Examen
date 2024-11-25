//
//  CovidView.swift
//  TC2007B-Examen
//
//  Created by Ian Julian Estrada Castro on 25/11/24.
//

import SwiftUI

struct CovidView: View {
    @StateObject var covidViewModel = CovidViewModel()
    @State private var countryInput: String = ""
    @State private var regionInput: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    var body: some View {
        NavigationView {
            VStack {
                // Input fields for country and region
                HStack {
                    TextField("Ingresa un país: ", text: $countryInput)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Ingresa una región: ", text: $regionInput)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding()
                
                Button {
                    print("Buscando país")
                    Task {
                        isLoading = true
                        errorMessage = nil
                        await covidViewModel.getCovidList(country: countryInput, region: regionInput)
                        isLoading = false
                    }
                    
                } label: {
                    Text("Cargar Datos")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                if isLoading {
                    ProgressView("Cargando datos...")
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if covidViewModel.covidList.isEmpty {
                    Text("No se encontraron datos")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(covidViewModel.covidList) { covid in
                        VStack (alignment: .leading) {
                            Text(covid.covid.country)
                            Text(covid.covid.region)
                                .foregroundColor(.gray)
                            
                            ForEach(covid.covid.cases.keys.sorted(), id: \.self) { date in
                                if let caseData = covid.covid.cases[date] {
                                    Text("Fecha: \(date)")
                                        .font(.caption)
                                    Text("Total: \(caseData.total). Nuevos casos: \(caseData.new)")
                                        .font(.caption2)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Datos COVID")
            .padding()
        }
    }
}

#Preview {
    CovidView()
}
