//
//  ImgDetailViewController.swift
//  ImageGallery
//
//  Created by Apple on 23/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import CoreData

class ImgDetailViewController: UIViewController {
    
    var image: UIImage?
    var url: String?
    var titre: String?
    var url2: URL?
    var favImg: String?
    var favTitreImg: String?
    var favIcone: Bool?
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var imgFav: UIImageView!
    
    @IBOutlet weak var titleImg: UILabel!
    @IBAction func onDoubleTap(_ sender: UITapGestureRecognizer){
        print("it's works !")
        
        let imageAsset = #imageLiteral(resourceName: "coeurFav")
        imgFav.image = imageAsset
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let img = NSEntityDescription.insertNewObject(forEntityName: "ImgFavoris", into: context) as! ImgFavoris
        print("will added: ",url, " and: ", titre)
        img.dataImg = url
        img.titreImg = titre
        print("favoris added !")
        
        appDelegate.saveContext()
        
    }
    
    @IBAction func onLongPress(_ sender: UILongPressGestureRecognizer) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       
        // create the alert
        let alert = UIAlertController(title: "Suppresion d'un favori", message: "Souhaitez vous vraiment supprimez cette image de vos favoris ?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Oui", style: UIAlertActionStyle.destructive, handler: { action in
            
            // do something like...
            Favoris.sharedInstance.removeFav(app:appDelegate,url:self.favImg!)
            _ = self.navigationController?.popViewController(animated: true)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Non", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageView.image = image
        
        //print(" * * * URL img detail wiew controller * * * ",Url)
        
        if (url == nil){
            let url = URL(string:self.favImg!)
            let dataImg = try? Data(contentsOf: url!)
            imageDetail.image = UIImage(data: dataImg!)
            titleImg.text = "Titre: "+favTitreImg!
            if favIcone == true {
                let imageAsset = #imageLiteral(resourceName: "coeurFav")
                imgFav.image = imageAsset

            }
        }
        else {
            let url = URL(string:self.url!)
            let dataImg = try? Data(contentsOf: url!)
            imageDetail.image = UIImage(data: dataImg!)
            titleImg.text = "Titre: "+titre!
            
            
        }
        
        
        
        //print("***",url,"***", dataImg,"****")
        //imageDetail.image = UIImage(data: dataImg!)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
