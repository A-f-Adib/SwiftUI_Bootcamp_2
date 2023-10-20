//
//  CacheMemory.swift
//  SwiftFul_Thinking_2nd
//
//  Created by A.f. Adib on 10/18/23.
//

import SwiftUI

//Class 1
class CacheManager {
    
    static let example = CacheManager()   //singleton
    
//    private init () {
//        
//    }
//    
    
    var imgCache : NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    
    
    func add (image : UIImage, name : String) ->String {
        imgCache.setObject(image, forKey: name as NSString)
        return "Added to cache"
    }
    
    
    func remove(name : String) -> String {
        imgCache.removeObject(forKey: name as NSString)
        return "Removed from cache"
    }
    
    
    func getImg (name : String) -> UIImage? {
        imgCache.object(forKey: name as NSString)
    }
}




//Class 2

class CacheViewModel : ObservableObject {
    
    @Published var startImage : UIImage? = nil
    @Published var cacheImage : UIImage? = nil
    @Published var infoMsg : String = ""
    
    let imageName : String = "steve-jobs"
    let newManager = CacheManager.example
    
    
    init() {
        getImgFromAsset()
    }
    
    
    func getImgFromAsset () {
        startImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let imagee = startImage else { return }
       infoMsg = newManager.add(image: imagee, name: imageName)
    }
    
    func removeCache  () {
       infoMsg = newManager.remove(name: imageName)
    }
    
    
    
    func getFromCache () {
        
        cacheImage = newManager.getImg(name: imageName)
        
        if cacheImage != nil {
            
            infoMsg = "Got image from Cache"
        } else {
            infoMsg = "Image not found in Cache"
        }
        
    }
}

struct CacheMemory: View {
    
    @StateObject var Cvm = CacheViewModel()
    
    
    var body: some View {
        NavigationView{
            VStack{
                if let image = Cvm.imageName {
                    
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width : 200, height : 200)
                        .cornerRadius(10)
                }
                
               
                
                HStack{
                    Button(action: {
                        Cvm.saveToCache()
                        
                    }, label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                            .padding(.top, 20)
                    })
                    
                    Button(action: {
                        Cvm.removeCache()
                        
                    }, label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                            .padding(.top, 20)
                    })
                }
                Button(action: {
                    Cvm.getFromCache()
                    
                }, label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(.green)
                        .cornerRadius(10)
                        .padding(.top, 10)
                })
                
                Text(Cvm.infoMsg)
                    .font(.headline)
                    .foregroundColor(.black)
                
                if let image = Cvm.cacheImage {
                    
                    Image(uiImage : image)
                        .resizable()
                        .scaledToFit()
                        .frame(width : 200, height : 200)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .navigationTitle("Cache Memory save")
        }
    }
}

struct CacheMemory_Previews: PreviewProvider {
    static var previews: some View {
        CacheMemory()
    }
}
