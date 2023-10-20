//
//  JsonEscaping.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/15/23.
//

import SwiftUI

struct postModel: Identifiable, Codable {
    let userId : Int
    let id : Int
    let title : String
    let body : String
}


class DownloadWithEscaping : ObservableObject {
    @Published var posts : [postModel] = []
    
    init() {
        getPost()
    }
    
    
    
    
    func getPost () {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else {
            return
        }
        
        downloadData(fromURL: url) { returndata in
            if let data = returndata {
                guard let newPost = try? JSONDecoder().decode([postModel].self, from: data)
                 else {
                     return
                 }
                 DispatchQueue.main.async { [weak self] in
                     self?.posts = newPost
                 }
                
            }
            else {
                print("no data")
            }
        }
        
    }
    
    
    
    
    func downloadData (fromURL url : URL, completion : @escaping (_ data : Data?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error downloading data")
                completion(nil)
                return
            }
            
            completion(data)
                   
        }.resume()
     
    }
}




struct JsonEscaping: View {
    
    @StateObject var jvm = DownloadWithEscaping()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(jvm.posts) { post in
                    VStack(alignment : .leading){
                        Text("\(post.id)")
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("JSON with escaping")
        }
    }
}

struct JsonEscaping_Previews: PreviewProvider {
    static var previews: some View {
        JsonEscaping()
    }
}
