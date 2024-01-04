//
//  ZenQuote.swift
//  Stufflu
//
//  Created by Sebastian Hajduk on 22/12/2023.
//

import Foundation

struct ZenQuoteRequest {
    static func getQuote(completion: @escaping (ZenQuote?) -> Void) {
        guard let url = URL(string: "https://zenquotes.io/api/today") else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data else { return }

            do {
                let quotes = try JSONDecoder().decode([ZenQuote].self, from: data)
                let todayQuote = quotes.first
                completion(todayQuote)
            } catch {
                completion(nil)
            }
        }

        task.resume()
    }
}
// swiftlint: disable identifier_name
struct ZenQuote: Codable {
    let a: String // author
    let q: String // quote
}
// swiftlint: enable identifier_name
