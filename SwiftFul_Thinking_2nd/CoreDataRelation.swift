//
//  CoreDataRelation.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/8/23.
//


// 36:20

import SwiftUI
import CoreData


class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    init (){
       container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores{ (description, error) in
            if let error = error {
                print("Error core data \(error)")
            }
        }
        context = container.viewContext
        
    }
    
    
    
    func Save(){
        do {
            try context.save()
            print("Saved successfully")
        } catch let error {
            print("Error save \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationModel : ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var businesses : [BusinessEntity] = []
    
    
    init() {
        getBusiness()
    }
    
    
    
    func addBusiness() {
     let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        save()
    }
    
    
    
    func getBusiness () {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching \(error)")
        }
    }
    
    
    
    func save() {
        manager.Save()
        getBusiness()
    }
}

struct CoreDataRelation: View {
    
    @StateObject var vM = CoreDataRelationModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing : 20){
                    Button(action: {
                        vM.addBusiness()
                    }, label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height : 55)
                            .frame(maxWidth : .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                    })
                    
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(alignment : .top){
                            ForEach(vM.businesses) { ndata in
                                businessView(entity: ndata)
                            }
                        }
                    })
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct CoreDataRelation_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelation()
    }
}


struct businessView : View{
    
    let entity : BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Name : \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity]{
                Text("Departments :")
                    .bold()
                ForEach(departments) { data in
                    Text(data.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees :")
                    .bold()
                ForEach(employees) { data in
                    Text(data.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth : 300, alignment: .leading)
        .background(.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
