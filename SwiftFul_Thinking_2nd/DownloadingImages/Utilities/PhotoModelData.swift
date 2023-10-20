//
//  PhotoModelData.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/20/23.
//

import Foundation
import Combine

class PhotoModelData {
    
    static let instance = PhotoModelData()
    
    @Published var photoModels : [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    
    private init () {
        DownloadData()
    }
    
    
    func DownloadData () {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
                
        else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { (Completion) in
                switch Completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error \(error)")
                }
            } receiveValue: { [weak self] (returnedPhoto) in
                self?.photoModels = returnedPhoto
            }
            .store(in: &cancellables)

    }
    
    
    
    func handleOutput (output : URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}
