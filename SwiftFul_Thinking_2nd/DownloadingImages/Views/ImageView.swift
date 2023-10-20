//
//  ImageView.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/20/23.
//

import SwiftUI

struct ImageView: View {
    
    @StateObject var loader : ImageLoadingView
    
    init (url : String) {
        _loader = StateObject(wrappedValue: ImageLoadingView(url: url))
    }
    
    var body: some View {
        ZStack{
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ImageView(url: "https://via.placeholder.com/600/92c952")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
