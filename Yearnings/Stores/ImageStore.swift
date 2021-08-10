//
//  ImageStore.swift
//  Yearnings
//

//

import Foundation
import Combine
import SwiftUI

protocol ImageStoreProtocol {
    func loadImage(fromUrl url: URL) -> AnyPublisher<UIImage, Never>
}

final class ImageStore: ImageStoreProtocol, ObservableObject {
    func loadImage(fromUrl url: URL) -> AnyPublisher<UIImage, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) ?? UIImage() }
            .replaceError(with: UIImage())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
