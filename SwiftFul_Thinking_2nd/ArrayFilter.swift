//
//  ArrayFilter.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/6/23.
//

import SwiftUI
struct userModel : Identifiable {
    let id = UUID().uuidString
    let name : String
    let points : Int
    let isVerified : Bool
}


class ArrayModification : ObservableObject {
    @Published var dataArray : [userModel] = []
    @Published var SortedArray : [userModel] = []
    @Published var filterArray : [userModel] = []
    
    init () {
        getUsers()
        updateFiter()
        
        newFilter()
    }
    
    func getUsers() {
       
        let user1 = userModel(name: "Abc", points: 20, isVerified: true)
        let user2 = userModel(name: "def", points: 49, isVerified: false)
        let user3 = userModel(name: "ghi", points: 90, isVerified: true)
        let user4 = userModel(name: "jkl", points: 85, isVerified: true)
        let user5 = userModel(name: "mno", points: 40, isVerified: false)
        let user6 = userModel(name: "pqr", points: 15, isVerified: true)
        let user7 = userModel(name: "stu", points: 50, isVerified: false)
        let user8 = userModel(name: "vwx", points: 25, isVerified: false)
        let user9 = userModel(name: "xyz", points: 70, isVerified: true)
        let user10 = userModel(name: "axz", points:30, isVerified: true)
        
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])
        
        
    }
    
    func updateFiter(){

        SortedArray = dataArray.sorted(by: { user1, user2 in
            user1.points > user2.points
        })
        
//    same code
//    filterArray = dataArray.sorted(by: {$0.points > $1.points})
    }
    
    
    func newFilter () {
        filterArray = dataArray.filter({ (data) -> Bool in
            return data.isVerified
        })
    }
}

struct ArrayFilter: View {
    
    @StateObject var Vmodel = ArrayModification()
    
    var body: some View {
        NavigationView {
            ScrollView{
                
                VStack(spacing : 20){
                    ForEach(Vmodel.SortedArray) { data in
                        VStack(alignment : .leading){
                            Text(data.name)
                                .font(.headline)
                            
                            HStack{
                                Text("Points : \(data.points)")
                                Spacer()
                                if data.isVerified {
                                    Image(systemName: "flame.fill")
                                }
                            }
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(.indigo)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarTitle("List array")
            .navigationBarItems(trailing:
                                    Button("Filter", action: {
                
            })
            )
        }
    }
}

struct ArrayFilter_Previews: PreviewProvider {
    static var previews: some View {
        ArrayFilter()
    }
}

