//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Will Carhart on 5/3/18.
//  Copyright © 2018 Will Carhart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Loading..."
        self.descriptionLabel.text = "Please wait..."
        self.copyrightLabel.text = ""
        
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            } else {
                print("error")
            }
        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        
        if photoInfo.mediaType == "video" {
            DispatchQueue.main.async {
                self.photo.backgroundColor = UIColor.orange
                
                self.title = photoInfo.title
                self.descriptionLabel.text = photoInfo.description
                self.descriptionLabel.sizeToFit()
                self.descriptionLabel.adjustsFontSizeToFitWidth = true
                
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text = "© \(copyright)"
                    self.copyrightLabel.sizeToFit()
                } else {
                    self.copyrightLabel.isHidden = true
                }
            }
        } else {
            URLSession.shared.dataTask(with: photoInfo.url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.photo.image = image
                        
                        self.title = photoInfo.title
                        self.descriptionLabel.text = photoInfo.description
                        self.descriptionLabel.sizeToFit()
                        self.descriptionLabel.adjustsFontSizeToFitWidth = true
                        
                        if let copyright = photoInfo.copyright {
                            self.copyrightLabel.text = "© \(copyright)"
                            self.copyrightLabel.sizeToFit()
                        } else {
                            self.copyrightLabel.isHidden = true
                        }
                    }
                }
                }.resume()
        }
        
        DispatchQueue.main.async {
            self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: /*UIScreen.main.bounds.size.height + */self.descriptionLabel.bounds.size.height)
        }
        
    }

}

