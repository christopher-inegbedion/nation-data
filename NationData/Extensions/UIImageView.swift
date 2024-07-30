//
//  UIImageView.swift
//  NationData
//
//  Created by Christopher Inegbedion on 29/07/2024.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, onDone: @escaping () -> Void) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                onDone()
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit, onDone: @escaping () -> Void) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode, onDone: onDone)
    }
}
