//
//  RatingView.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/6/23.
//

import SwiftUI

struct RatingView: View {
    
    @State var rating : Int = 0
    
    var body: some View {
        VStack(spacing : 40) {
            HStack{
                ForEach(1..<6) { index in
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(rating >= index ? .yellow : .gray)
                        .onTapGesture {
                            withAnimation(.spring()){
                                rating = index
                            }
                            
                        }
                    
                   
                    
                }
            }
            Text(rating == 0 ? "Rate 👍" : rating <= 2 ? "Bad 😞": rating <= 4 ? "Good 😀" : "Best 😍")
                .padding()
                .font(.title)
                .foregroundColor(.black)
                .background(.mint)
                .cornerRadius(10)
                
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
