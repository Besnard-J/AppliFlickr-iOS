//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by Apple on 23/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

      @IBOutlet weak var imageView: UIImageView!
      //@IBOutlet weak var imgNoResult: UIImageView!
      var url:String?
      var titre:String?
      var favImg: String?
      var favTitreImg: String?
      var url2 : URL?
      var favIcone: Bool?
}
