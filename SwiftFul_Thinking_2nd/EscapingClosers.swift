//
//  EscapingClosers.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/10/23.
//

import SwiftUI


class EscapingViewModel : ObservableObject {
    
    @Published var text: String = "Hello"
    @Published var text2 : String = "Hello2"
    @Published var text3 : String = "Hello3"
    @Published var text4 : String = "Hello4"
    @Published var text5 : String = "Hello5"
    
    func downloadData() -> String {
        return  "New data"
    }
    
    func downloadData2(completion : (_ data : String) -> Void) {
        completion("New Data 2")
    }
    
    func downloadData3(completion : @escaping (_ data : String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion("New Data 3")
        }
    }
    
    func downloadData4(completion : @escaping (downloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let result = downloadResult(data: "New Data 4")
            completion(result)
        }
    }
    
    func downloadData5(completion : @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let result = downloadResult(data: "New Data 5")
            completion(result)
        }
    }
    
    
    
    
    
    
    
    
    func getData () {
        let newData = downloadData()
        text = newData
    }
    func getData2 () {
        downloadData2 { returnData in
            text2 = returnData
        }
    }
    func getData3 () {
        downloadData3 { [weak self] returnData in
            self?.text3 = returnData
        }
    }
    func getData4 () {
        downloadData4 { [weak self] returnResult in
            self?.text4 = returnResult.data
        }
    }
    func getData5 () {
        downloadData5 { [weak self] returnResult in
            self?.text5 = returnResult.data
        }
    }
    
}


struct downloadResult {
    let data : String
}

typealias DownloadCompletion = (downloadResult) -> Void


struct EscapingClosers: View {
    
    @StateObject var Evm = EscapingViewModel ()

    var body: some View {
        VStack{
            Text(Evm.text)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .bold()
                .onTapGesture {
                    Evm.getData()
                }
            
            Text(Evm.text2)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .bold()
                .onTapGesture {
                    Evm.getData2()
                }
            
            Text(Evm.text3)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .bold()
                .onTapGesture {
                    Evm.getData3()
                }
            Text(Evm.text4)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .bold()
                .onTapGesture {
                    Evm.getData4()
                }
            Text(Evm.text5)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .bold()
                .onTapGesture {
                    Evm.getData5()
                }
        }
    }
}

struct EscapingClosers_Previews: PreviewProvider {
    static var previews: some View {
        EscapingClosers()
    }
}
