//
//  JsonWithCombine.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/15/23.
//

import SwiftUI
import Combine


struct PostModel: Identifiable, Codable {
    let userId : Int
    let id : Int
    let title : String
    let body : String
}


class DownloadWithCombine : ObservableObject {
    
    @Published var Posts : [PostModel] = []
    var canclellable = Set<AnyCancellable>()
    
    init() {
        GetPost()
    }
    
    
    
    
    func GetPost () {
        
        guard let Url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else {
            return
        }
        
        
        URLSession.shared.dataTaskPublisher(for: Url)
            .receive(on : DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (returnedPost) in
                self?.Posts = returnedPost
            })
            .store(in: &canclellable)
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



struct JsonWithCombine: View {
    
    @StateObject var Jcvm = DownloadWithCombine()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(Jcvm.Posts) { post in
                    VStack(alignment : .leading){
                        Text("\(post.id)")
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("JSON with Combine")
        }
    }
}

struct JsonWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        JsonWithCombine()
    }
}
