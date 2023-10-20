//
//  CodableProtocol.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/11/23.
//

import SwiftUI


// codable = encodable + decodable

struct customerModel : Identifiable, Codable {
    let id : String
    let name : String
    let points : Int
    let isPremium : Bool
}


class CodableViewModel : ObservableObject {
    
    @Published var Customer : customerModel? = nil
    
    init() {
        getData()
    }
    
    
    
    
    func getData () {
        guard let data = getJSONData() else { return }
        self.Customer = try? JSONDecoder().decode(customerModel.self, from: data)
    }
    
    
    
    
    func getJSONData () -> Data? {
        let customer = customerModel(id: "111", name: "Emily", points: 100, isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
        
        return jsonData
    }
}




struct CodableProtocol: View {
    
    @StateObject var Cvm = CodableViewModel()
    
    var body: some View {
        
        VStack(spacing : 20){
            if let customers = Cvm.Customer {
                
                Text(customers.id)
                Text(customers.name)
                Text("\(customers.points)")
                Text(customers.isPremium.description)
            }
        }
    }
}

struct CodableProtocol_Previews: PreviewProvider {
    static var previews: some View {
        CodableProtocol()
    }
}
