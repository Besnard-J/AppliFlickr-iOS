//
//  FlickrService.swift
//  ClientFilckrPerso
//
//  Created by Apple on 24/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit

class FlikrService {
    
    static let sharedInstance: FlikrService = {
        let instance = FlikrService()
        
        return instance
    }()
    
    let session  = URLSession.shared
    
    let methodAPI = "flickr.photos.search"
    
    var keyAPI = "" //= "18dfedb92a573089afd432d36ce4e7fa"
    
    var Tag = ""
    
    var nbImg = 0
    
    var nbPage = 1
    
    var urlImgArrayS : [String] = []
    
    var urlImgArrayO : [String] = []
    
    enum FlickrServiceError: Error {
        case apiMethodCall
        case noDataFound
        //case insufficientFunds(coinsNeeded: Int)
        case jsonDeserialization
        case invalidData
    }
    

    //func getImg (cell:ImageCollectionViewCell,indexPath: IndexPath) -> Void {
    func getImg (tag: String, nbimage: Int, callback: @escaping (_ tabPhoto:[Photo] )-> Void)
    {
        
//        print("*** plop ***")
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
        //let data = NSArray(contentsOfFile: path),
        let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, String>
        {
            print("*** my key: ", dict["ApiKey"]!, " ***")
            keyAPI = dict["ApiKey"]!
        }

        
        Tag = tag
        nbImg = nbimage
//      nbPage = nbpage
        
        let imgUrl = URL(string:"https://api.flickr.com/services/rest/?method=\(methodAPI)&api_key=\(keyAPI)&tags=\(Tag)&per_page=\(nbImg)&page=\(nbPage)&format=json&nojsoncallback=1")

        // print(" * * * urlImgArrayS * * * ",urlImgArrayS)
        // print(" * * * urlImgArrayO * * * ",urlImgArrayO)
        
        let task = session.dataTask(with: imgUrl!) {
            (data, response,error) in
            guard error == nil else {
                print("error calling FlickrService.search")
                return
            }
            
            guard let data = data else {
                print("no data from FlickrService.search")
                return
            }
            
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any] else {
                print("cannot deserialize JSON")
                return
            }
            //     print(" * * * JsonObjetc * * * ",jsonObject)
            
            guard let photosParent = jsonObject["photos"] as? [String:Any] else {
                print("no photo properties found")
                return
            }
            //   print(" * * * PhotoParent * * * ",photosParent)
            
            guard let photos = photosParent["photo"]  as? [[String:Any]] else {
                print("no photo properties found")
                return
            }
            //  print(" * * * Photo * * * ",photos)
            
            let flickrPhotos = photos.map {
                Photo(
                    farm: $0["farm"] as! Int,
                    id: $0["id"] as! String,
                    isfamily: $0["isfamily"] as! Bool,
                    isfriend: $0["isfriend"] as! Bool,
                    ispublic: $0["ispublic"] as! Bool,
                    owner: $0["owner"] as! String,
                    secret: $0["secret"] as! String,
                    server: $0["server"] as! String,
                    title: $0["title"] as! String)
            }
            // print(" * * * flickrPhoto * * * ",flickrPhotos)
            
            callback(flickrPhotos)
            
//            for img in flickrPhotos {
//                //  print(" * * * test url * * * ",img.getImg_Small())
//                // print(" * * * test url * * * ",img.getImg_Original())
//                self.urlImgArrayS.append(img.getImg_Small())
//                self.urlImgArrayO.append(img.getImg_Original())
//                //print(urlImgArrayS[indexPath.row])
//            }
//            let url = URL(string: self.urlImgArrayS[indexPath.row])
//            let dataImg = try? Data(contentsOf: url!)
//            cell.imageView.image = UIImage(data: dataImg!)
//            cell.url = self.urlImgArrayO[indexPath.row]
//            print(" * * * urlImgArrayS * * * ",urlImgArrayS)
//            print(" * * * urlImgArrayO * * * ",urlImgArrayO)
            
        }
        task.resume()
    }
    
//    func getImgSmall() -> [String] {
//        getImg(tag: Tag, nbimage: nbImg, nbpage: nbPage)
//        return urlImgArrayS
//    }
//    
//    func getImgBig() -> [String] {
//        getImg(tag: Tag, nbimage: nbImg, nbpage: nbPage)
//        return urlImgArrayO
//    }
    
}
