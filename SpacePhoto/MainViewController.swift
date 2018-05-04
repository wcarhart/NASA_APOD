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
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage.alpha = 0.5
        
        updateTodayButton()
    }
    
    func updateTodayButton() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todaysDate = Date()
        if dateFormatter.string(from: todaysDate) == dateFormatter.string(from: datePicker.date) {
            UIView.animate(withDuration: 0.1) {
                self.todayButton.setTitleColor(UIColor.darkGray, for: .normal)
                self.todayButton.isHidden = true
                self.todayButton.isEnabled = false
            }
        } else {
            UIView.animate(withDuration: 0.1) {
                self.todayButton.setTitleColor(UIColor.white, for: .normal)
                self.todayButton.isHidden = false
                self.todayButton.isEnabled = true
            }
        }
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        updateTodayButton()
    }
    
    @IBAction func todayButtonPressed(_ sender: Any) {
        let todaysDate = Date()
        datePicker.setDate(todaysDate, animated: true)
        updateTodayButton()
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
