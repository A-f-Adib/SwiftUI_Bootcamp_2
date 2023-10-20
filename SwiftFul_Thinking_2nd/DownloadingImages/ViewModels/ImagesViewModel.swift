//
//  ImagesViewModel.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/20/23.
//

import Foundation
import Combine

class ImagesViewModel : ObservableObject {
    
    @Published var dataArray : [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService = PhotoModelData.instance
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers () {
        dataService.$photoModels
            .sink { [weak self] (returnedPhoto) in
                self?.dataArray = returnedPhoto
            }
            .store(in: &cancellables)
    }
}
