//
//  MainViewController.swift
//  SpacePhoto
//
//  Created by Will Carhart on 5/3/18.
//  Copyright © 2018 Will Carhart. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        let selectedDate = datePicker.date
        let todayDate = Date()
        if selectedDate > todayDate {
            UIView.animate(withDuration: 0.1, animations: {
                self.datePicker.transform = CGAffineTransform(rotationAngle: .pi / 10)
            }) { (_) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.datePicker.transform = CGAffineTransform(rotationAngle: .pi / -10)
                }) { (_) in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.datePicker.transform = CGAffineTransform(rotationAngle: .pi / 10)
                    }) { (_) in
                        UIView.animate(withDuration: 0.1) {
                            self.datePicker.transform = CGAffineTransform.identity
                        }
                    }
                }
            }
        } else {
            performSegue(withIdentifier: "showDate", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDate" else { return }
        let navController = segue.destination as! UINavigationController
        let destination = navController.childViewControllers.first as! ViewController
        destination.dateToSearch = datePicker.date
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        
    }
    
}
