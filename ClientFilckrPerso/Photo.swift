//
//  Photo.swift
//  ClientFilckrPerso
//
//  Created by Apple on 29/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

struct Photo {
    
    let farm: Int
    let id: String
    let isfamily: Bool
    let isfriend: Bool
    let ispublic: Bool
    let owner: String
    let secret: String
    let server: String
    let title: String
    
    func getImg_Small() -> String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_q.jpg"
    }
    func getImg_Original() -> String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_c.jpg"
        
    }
    
    func getTitle() -> String {
        return title
    }
}
