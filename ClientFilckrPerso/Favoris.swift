//
//  Favoris.swift
//  ClientFilckrPerso
//
//  Created by Apple on 06/04/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Favoris{
    
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let sharedInstance: Favoris = {
        let instance = Favoris()
        
        return instance
    }()
    //let session  = URLSession.shared
    
    var lstImg : [String] = []
    var lstTxt : [String] = []
    
    func getFav (callback: @escaping (_ tabImg:[String], _ tabTxt:[String] )-> Void){
        let context = appDelegate.persistentContainer.viewContext
        context.perform {
            
            // - flech entity -
            let imgFlecthRequest : NSFetchRequest<ImgFavoris> = ImgFavoris.fetchRequest()
            imgFlecthRequest.sortDescriptors = [NSSortDescriptor(key: "dataImg",ascending: false)]
            
            do {
                let flecthImgFavoris =  try imgFlecthRequest.execute()
                
                self.lstImg.removeAll()
                self.lstTxt.removeAll()
                
                if flecthImgFavoris.count == 0
                {
                    self.lstImg = []
                    self.lstTxt = []
                }
                    
                else{
                    
                let nb = flecthImgFavoris.count
                for i in 0...nb-1
                {
//                    print("test",flecthImgFavoris[i].dataImg)
                    
                    self.lstImg.append(flecthImgFavoris[i].dataImg!)
                    self.lstTxt.append(flecthImgFavoris[i].titreImg!)
                    
//                    print("result for img",self.lsImg)
                }
//                    print("nb result fin titre: ", self.lstImg.count)
//                    print("result fin titre: ", self.lstImg)
                }
                callback (self.lstImg, self.lstTxt)
            }
                
            catch{
                fatalError("Failled to flecth : \(error)")
            }
            
        }
        //return lstImg
    }
    
    
//    func getTxtFav (app: AppDelegate, lTxt: [String]) -> [String]{
//        let context = app.persistentContainer.viewContext
//        context.perform {
//            
//            // - flech entity -
//            let titreFlecthRequest : NSFetchRequest<ImgFavoris> = ImgFavoris.fetchRequest()
//            titreFlecthRequest.sortDescriptors = [NSSortDescriptor(key: "titreImg",ascending: true)]
//            
//            do {
//                
//                let flecthTitreFavoris =  try titreFlecthRequest.execute()
//                
//                self.lstTxt.removeAll()
//                
//                
//                if flecthTitreFavoris.count == 0
//                {
//                    self.lstTxt = []
//                }
//                else{
//                let nb = flecthTitreFavoris.count
//                for i in 0...nb-1
//                {
////                    print("test",flecthTitreFavoris[i].titreImg)
//                    self.lstTxt.append(flecthTitreFavoris[i].titreImg!)
////                    print("result for txt",self.lsTxt)
//                }
//                
////                print("nb result fin titre: ", self.lstTxt.count)
////                print("result fin titre: ", self.lstTxt)
//                
//                }
//            }
//                
//            catch{
//                fatalError("Failled to flecth : \(error)")
//            }
//            
//        }
//        return lstTxt
//    }
    
    func removeFav(app: AppDelegate,url: String) -> Void {
        let context = app.persistentContainer.viewContext
        context.perform {
           let imgFlecthRequest : NSFetchRequest<ImgFavoris> = ImgFavoris.fetchRequest()
            imgFlecthRequest.predicate = NSPredicate(format: "dataImg == '\(url)'")
            
//            print("suppression demander de: ",url)
//            print("result requette : ",imgFlecthRequest)
            
            if let result = try? context.fetch(imgFlecthRequest) {
                for object in result {
                    context.delete(object)
//                    print("suppression faite de: ", object)
                }
                app.saveContext()
            }
            else {
                print("******** fail *********")
            }
        }
    }
    
//    func saveImg () {
//        let imageName = "my-image"
//        if let doucumentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        {
//            let imagePath = doucumentDirectoryURL.appendingPathComponent(imageName)
//            if let imageURL = URL(string:"https://s-media-cache-ak0.pinimg.com/originals/e6/52/48/e65248a817c2ab7bcd4c338fbcd913fe.jpg"),
//                let data = try? Data(contentsOf: imageURL),
//                let image = UIImage(data: data)
//            {
//                do
//                {
//                    try UIImageJPEGRepresentation(image, 1.0)?.write(to: imagePath)
//                }
//                catch
//                {
//                    fatalError("Can't write image ! \(error)")
//                }
//                guard let loadedImage = UIImage(contentsOfFile: imagePath.path)
//                else
//                {
//                    fatalError("Can't read image !")
//                }
//            }
//        }
//    }
}
