//
//  imageRow.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/20/23.
//

import SwiftUI



struct imageRow: View {
    
    let data : PhotoModel
    
    var body: some View {
        HStack{
            ImageView(url: data.url)
                .frame(width: 75, height: 75, alignment: .leading)
            VStack(alignment : .leading){
                Text(data.title)
                    .font(.headline)
                Text(data.url)
                    .foregroundColor(.gray)
                    .italic()
            }
            .frame(maxWidth : .infinity, alignment: .leading)
        }
    }
}

struct imageRow_Previews: PreviewProvider {
    static var previews: some View {
        imageRow(data: PhotoModel(albumId: 1, id: 1, title: "title", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/600/92c952"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
