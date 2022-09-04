//
//  ContentView.swift
//  GraphlQLPrac-Countries
//
//  Created by Kim Insub on 2022/09/04.
//

import SwiftUI

struct ContentView: View {

    @State var countries: [GetAllCountriesQuery.Data.Country] = []

    var body: some View {
        NavigationView {

            List(countries, id: \.name) { country in
                HStack {
                    Text(country.emoji)
                    Text(country.name)
                }
            }
            .navigationTitle("Countries")
            .onAppear {
                Network.shared.apollo.fetch(query: GetAllCountriesQuery()) {
                    result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            if let countries = response.data?.countries {
                                self.countries = countries
                            }
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
