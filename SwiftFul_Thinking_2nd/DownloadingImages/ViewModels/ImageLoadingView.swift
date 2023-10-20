//
//  ImageLoadingView.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/20/23.
//

import Foundation
import SwiftUI
import Combine


class ImageLoadingView : ObservableObject {
    
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    let urlString : String
    
    init (url : String) {
        urlString = url
        downloadImage()
    }
    
    func downloadImage () {
        isLoading = true
        guard let url = URL(string: urlString) else
        {
            isLoading = false
            return
        }
        
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map {UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}

