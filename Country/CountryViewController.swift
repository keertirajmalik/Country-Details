//
//  CountryViewController.swift
//  Country
//
//  Created by Keertiraj Laxman Malik on 09/02/22.
//

import UIKit

class CountryViewController: UIViewController {
    
    var countryFlag: URL?
    @IBOutlet var countryFlagView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = countryFlag {
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.countryFlagView.image = UIImage(data: data!)
                }
            }
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
