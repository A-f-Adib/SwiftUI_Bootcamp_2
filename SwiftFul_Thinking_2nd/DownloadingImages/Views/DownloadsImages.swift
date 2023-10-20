//
//  DownloadsImages.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/20/23.
//


//requirements:

//codable
//background threads
//weak self
//combine
//publishers and subscribers
//filemanager
//nscache


import SwiftUI

struct DownloadsImages: View {
    
    @StateObject var Ivm = ImagesViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(Ivm.dataArray) { data in
                    
                    imageRow(data: data)
                    
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

struct DownloadsImages_Previews: PreviewProvider {
    static var previews: some View {
        DownloadsImages()
    }
}
