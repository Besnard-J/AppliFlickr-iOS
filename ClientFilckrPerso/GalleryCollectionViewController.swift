//
//  GalleryCollectionViewController.swift
//  ImageGallery
//
//  Created by Apple on 23/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import CoreData


private var reuseIdentifier = "image-cell"

class GalleryCollectionViewController: UICollectionViewController {
    
    let queue1 = DispatchQueue(label: "com.maBoite.monAppli.maQueue1", qos: .background, attributes: .concurrent)
    //let queue2 = DispatchQueue(label: "com.maBoite.monAppli.maQueue2", qos: .background)
    
    var urlImg: [Photo] = []
    //    var urlImgS: [String] = []
    var Tag = ""
    var nbImg = 0
    //    var nbPage = 0
    var lsImg: [String] = []
    var lsTitreImg: [String] = []
    
    @IBOutlet weak var titreNav: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        print("my tag ", Tag)
        if Tag.isEmpty == false {
            FlikrService.sharedInstance.getImg(tag: Tag, nbimage: nbImg){
                (tabPhoto : [Photo]) in
                DispatchQueue.main.async {
                    self.urlImg = tabPhoto
                    self.collectionView!.reloadData()
                }
            }
            titreNav.title = "result for: "+Tag
        }
            
        else{
            
            Favoris.sharedInstance.getFav(){
                (tabImg : [String], tabTxt : [String]) in
                DispatchQueue.main.async {
                    self.lsImg = tabImg
                    self.lsTitreImg = tabTxt
                    self.collectionView!.reloadData()
                }
            }
            titreNav.title = "Favoris sauvegarder"
        }
        
//        if Tag.isEmpty == false && urlImg.count == 0 {
//            print("plop c'est raté")
//            let alertController = UIAlertController(title: "Tag not found", message:
//                "il n'y a aucun resultat pour votre recherche!   :( ", preferredStyle: UIAlertControllerStyle.alert)
//            alertController.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default,handler: nil))
//            
//            self.present(alertController, animated: true, completion: nil)
//        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // a chaque fois que la vue s'affiche
    override func viewWillAppear(_ animated: Bool) {
        print("plop apear !")
        
        self.lsImg.removeAll()
        self.lsTitreImg.removeAll()
        Favoris.sharedInstance.getFav(){
            (tabImg : [String], tabTxt : [String]) in
            DispatchQueue.main.async {
                self.lsImg = tabImg
                self.lsTitreImg = tabTxt
                self.collectionView!.reloadData()
            }
        }

    
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // print("* * * segue * * *",segue.identifier)
        if segue.identifier == "imgSegue" {
            //  print("*** plop ***")
            if let cell = sender as? ImageCollectionViewCell,
                let detailImage = segue.destination as? ImgDetailViewController {
                // si on voulait l'indexPath
                // let indexPath = self.collectionView?.indexPath(for: cell)
                //  print(" * * * URL cell gallery collection * * * ",cell.url)
                if urlImg.isEmpty {
                    detailImage.favImg = cell.favImg
                    detailImage.favTitreImg = cell.favTitreImg
                    detailImage.favIcone = cell.favIcone
                }
                    
                else {
                    detailImage.url = cell.url
                    detailImage.titre = cell.titre
                }
            }
        }
        
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        print("***** nbls: ", lsImg.count," and nburl: ",urlImg.count, " *****")
        //        if Tag.isEmpty == false && urlImg.count == 0 {
        //            return 1
        //        }
        
        if urlImg.count == 0
        {
            return lsImg.count
        }
            
        else if Tag.isEmpty == false && urlImg.count == 0
        {
            return urlImg.count
        }
            
        else if Tag.isEmpty == false && urlImg.count == 0 && lsImg.count != 0
        {
            return urlImg.count
        }
            
        else
        {
            return urlImg.count
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        
        //let imgIndexPath = self.collectionView?.indexPath(for: cell)
        
        // Configure the cell
        //getImg(cell: cell,indexPath: indexPath)
        //print("cell",self.lsImg[indexPath.row].dataImg)
        
        if self.urlImg.isEmpty {
            queue1.async {
                let url = URL(string: (self.lsImg[indexPath.row]))
                let dataImg = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: dataImg!)
                    //cell.url2 = url
                    cell.favImg = self.lsImg[indexPath.row]
                    cell.favTitreImg = self.lsTitreImg[indexPath.row]
                    cell.favIcone = true
                }
            }
        }
        else{
            queue1.async {
                let url = URL(string: self.urlImg[indexPath.row].getImg_Small())
                let dataImg = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: dataImg!)
                    cell.url = self.urlImg[indexPath.row].getImg_Original()
                    cell.titre = self.urlImg[indexPath.row].getTitle()
                }
            }
        }
        
        return cell
        
    }
    
    
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
