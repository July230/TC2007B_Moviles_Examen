//
//  CovidView.swift
//  TC2007B-Examen
//
//  Created by Ian Julian Estrada Castro on 25/11/24.
//

import SwiftUI

struct CovidView: View {
    @StateObject var covidViewModel = CovidViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if covidViewModel.covidList.isEmpty {
                    Text("Cargando datos...")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(covidViewModel.covidList) { covid in
                        VStack (alignment: .leading) {
                            Text(covid.country)
                            Text(covid.region)
                                .foregroundColor(.gray)
                            
                            ForEach(covid.cases.keys.sorted(), id: \.self) { date in
                                if let caseData = covid.cases[date] {
                                    Text("Fecha \(date)")
                                        .font(.caption)
                                    Text("Total: \(caseData.total). Nuevos: \(caseData.new)")
                                        .font(.caption2)
                                }
                            }
                        }
                    }
                }
            }.navigationTitle("Datos COVID")
            .onAppear {
                // onAppear does not support concurrence, we solve it with task
                Task {
                    await covidViewModel.getCovidList()
                }
            }
        }
    }
}

#Preview {
    CovidView()
}
