//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Will Carhart on 5/3/18.
//  Copyright © 2018 Will Carhart. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    var photoInfoController: PhotoInfoController?
    var url: URL?
    
    var dateToSearch: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoInfoController = PhotoInfoController(dateToSearch!)
        
        self.title = "Loading..."
        self.descriptionLabel.text = "Please wait..."
        self.copyrightLabel.text = ""
        
        photoInfoController?.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                if photoInfo.mediaType == "video" {
                    let urlString = "https:\(photoInfo.url?.absoluteString ?? "")"
                    self.url = URL(string: urlString)
                } else {
                    self.url = photoInfo.url
                }
                
                if self.url == nil {
                    DispatchQueue.main.async {
                        self.title = "No media found"
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MMM-dd-yyyy"
                        let errorDate = dateFormatter.string(from: self.dateToSearch!)
                        self.descriptionLabel.text = "No media found for \(errorDate)"
                    }
                } else {
                    self.updateUI(with: photoInfo)
                }
            }
        }
    }
    
    @IBAction func mediaTapped(_ sender: Any) {
        if let url = self.url {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        
        if photoInfo.mediaType == "video" {
            DispatchQueue.main.async {
                self.photo.backgroundColor = UIColor.lightGray
                let mediaLabel = UILabel(frame: self.photo.frame)
                mediaLabel.textAlignment = .center
                mediaLabel.numberOfLines = 0
                mediaLabel.text = "\n\n\n\n\nTap here to view video!"
                self.view.addSubview(mediaLabel)
                
                self.title = photoInfo.title ?? "Untitled"
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
            URLSession.shared.dataTask(with: photoInfo.url!) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.photo.image = image
                        
                        self.title = photoInfo.title ?? "Untitled"
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
            self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: self.descriptionLabel.bounds.size.height)
        }
        
    }

}

