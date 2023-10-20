//
//  PhotoModel.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/20/23.
//

import Foundation


struct PhotoModel : Identifiable, Codable {
    
    let albumId : Int
    let id : Int
    let title : String
    let url : String
    let thumbnailUrl : String
}
