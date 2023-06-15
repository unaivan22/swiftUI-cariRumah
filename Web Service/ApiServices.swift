//
//  ApiServices.swift
//  carirumah (iOS)
//
//  Created by unaivan on 15/06/23.
//

import Foundation
class RumahViewModel: ObservableObject {
    @Published var rumahs = [Rumah]()

    func fetchRumahs() {
        guard let url = URL(string: "https://raw.githubusercontent.com/unaivan22/openJson/main/rumahsubsidi.json") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let rumahs = try decoder.decode([Rumah].self, from: data)
                    DispatchQueue.main.async {
                        self.rumahs = rumahs
                    }
                } catch {
                    print("Error decoding JSON slur: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
