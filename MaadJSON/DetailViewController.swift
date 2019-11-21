//
//  DetailViewController.swift
//  MaadJSON
//
//  Created by Noman Yousuf on 11/18/19.
//  Copyright © 2019 colors. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var titleUIlabel: UILabel!
    @IBOutlet weak var detailUIlabel: UILabel!

     var stringForTitle = ""
          var nameD: String{
              get{
                  return stringForTitle
              }
              set{
                  stringForTitle = String(newValue)
              }
          }
    
    var stringForDetail = ""
    var detailD: String{
        get{
            return stringForDetail
        }
        set{
            stringForDetail = String(newValue)
        }
    }
    
    var stringForURL = ""
    var stringURL: String{
        get{
            return stringForDetail
        }
        set{
            stringForDetail = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        #if ipad
        titleUIlabel.font = titleUIlabel.font.withSize(30)
        detailUIlabel.font = detailUIlabel.font.withSize(30)
        #else
        
        #endif
        
        titleUIlabel.text = stringForTitle
        detailUIlabel.text = stringForDetail
        
        if let url = URL(string: stringForURL){
            
           func setImage(from url: String) {
               guard let imageURL = URL(string: url) else { return }

                   // just not to cause a deadlock in UI!
               DispatchQueue.global().async {
                   guard let imageData = try? Data(contentsOf: imageURL) else { return }

                   let image = UIImage(data: imageData)
                   DispatchQueue.main.async {
                    self.profileImage.image = image
                   }
               }
           }
            
           setImage (from: stringForURL)
            
        } else{
           // let imageName = UIImage(systemName: "person.crop.circle.fill.badge.exclam")
            
            
           // profileImage.image = UIImage(systemName: "person.crop.circle.fill.badge.exclam")
        }

        
        
       
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
