//
//  CoreDataMvvm.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/8/23.
//

import SwiftUI
import CoreData



class CoreDataViewModel : ObservableObject {
    
    let container : NSPersistentContainer
    @Published var saveEntity : [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error code data. \(error)")
            } else {
                print("Success")
            }
        }
        fetchFruits()
    }
    
    
    
    func fetchFruits () {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do{
          saveEntity = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error)")
        }
    }
    
    
    
    func addFruit (text : String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    
    func deleteFruit (indexSet : IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = saveEntity[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving \(error)")
        }
    }
    
}

struct CoreDataMvvm: View {
    
    @StateObject var Vm = CoreDataViewModel()
    @State var textfield : String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing : 20){
                TextField("Add fruits...", text: $textfield)
                    .font(.headline)
                    .padding()
                    .frame(height: 55)
                    .background(.gray.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    
                    guard !textfield.isEmpty else { return }
                    Vm.addFruit(text: textfield)
                    textfield = ""
                    
                }, label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame( height: 55)
                        .frame(maxWidth : .infinity)
                        .background(.pink.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal)
                })
                
                List{
                    ForEach(Vm.saveEntity) { data in
                        Text(data.name ?? "No name")
                    }
                    .onDelete(perform: Vm.deleteFruit)
                }
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataMvvm_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataMvvm()
    }
}
