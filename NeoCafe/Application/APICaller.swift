//
//  APICaller.swift
//  NeoCafe
//
//  Created by Pokerface on 05.06.2024.
//

import UIKit

struct APICaller {
    
    static func loadImage(imageURL: String) async -> UIImage? {
        guard let url = URL(string: imageURL) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        guard let (data, _) = try? await URLSession.shared.data(for: request),
              let image = UIImage(data: data) else { return nil }
        return image
    }
}
