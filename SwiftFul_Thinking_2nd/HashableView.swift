//
//  HashableView.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/6/23.
//

import SwiftUI

struct CustomModel : Hashable {
    let title : String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}


struct CustomModel2 : Identifiable {
    
   let id = UUID().uuidString
   let title2 : String
}

struct HashableView: View {
    
    let Model : [CustomModel] = [
        CustomModel(title: "Hashable Title 1"),
        CustomModel(title: "Hashable Title 2"),
        CustomModel(title: "Hashable Title 3"),
        CustomModel(title: "Hashable title 4"),
        CustomModel(title: "Hashable Title 5")
    ]
    
    
    let Model2 : [CustomModel2] = [
        CustomModel2(title2: "Identifiable Title 6"),
        CustomModel2(title2: "Identifiable Title 7"),
        CustomModel2(title2: "Identifiable Title 8"),
        CustomModel2(title2: "Identifiable Title 9"),
        CustomModel2(title2: "Identifiable Title 10")
    ]
    
    
    var body: some View {
        VStack(spacing : 20){
            ForEach(Model , id : \.self) { data in
                
                Text(data.title )
                    .font(.headline)
            }
            
            Divider()
            
            ForEach(Model2) { data2 in
                Text(data2.title2)
                    .font(.headline)
            }
        }
    }
}

struct HashableView_Previews: PreviewProvider {
    static var previews: some View {
        HashableView()
    }
}
