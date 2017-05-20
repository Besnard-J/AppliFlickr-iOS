//
//  AcceuilViewController.swift
//  ClientFilckrPerso
//
//  Created by Apple on 30/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class AcceuilViewController: UIViewController {
    
    static let sharedInstance: AcceuilViewController = {
        let instance = AcceuilViewController()
        
        return instance
    }()
    
    @IBOutlet weak var textTag: UITextField!
    
    @IBOutlet weak var nbImgSet: UITextField!
    
   // @IBOutlet weak var nbPageSet: UITextField!
    
    @IBOutlet weak var stepImg: UIStepper!
    
    //@IBOutlet weak var stepPage: UIStepper!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBAction func addImg(_ sender: UIStepper) {
        nbImgSet.text = Int(sender.value).description
        self.view!.endEditing(true)
    }
    
    @IBAction func closeKeybord(_ sender: UIButton) {
        self.view!.endEditing(true)
        //print("closeKeybord")
    }
    
    @IBAction func KeyboardClose(_ sender: UITextField) {
        self.view!.endEditing(true)
       // print("**KeyboardClose**")
        
    }
   
// @IBAction func addPage(_ sender: UIStepper) {
//        nbPageSet.text = Int(sender.value).description
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                   }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //print("* * * segue * * *",segue.identifier)
        if segue.identifier == "valueSegue" {
            if let detailImage = segue.destination as? GalleryCollectionViewController {
                // si on voulait l'indexPath
                // let indexPath = self.collectionView?.indexPath(for: cell)
                if (textTag.text?.isEmpty)! {
                   print("champ texte vide !")
                    let alertController = UIAlertController(title: "Saisie incorect", message:
                        "Le champ texte ne doit pas être vide !", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    let txt = textTag.text!.replacingOccurrences(of: " ",with: "+")
                    detailImage.Tag = txt
                }
                
                if nbImgSet.text == String(0) || (nbImgSet.text?.isEmpty)! {
                    detailImage.nbImg = 500
                }
                else{
                    detailImage.nbImg = Int(nbImgSet.text!)!
               }
//                    detailImage.nbPage = Int(nbPageSet.text!)!
            }
            
        }
        
    }
    
    //    func getNbImg() -> Int {
    //        return nbImg
    //    }
    
}
