//
//  WelcomeScreenViewController.swift
//  NationData
//
//  Created by Christopher Inegbedion on 23/08/2024.
//

import UIKit
import SwiftUI

class WelcomeScreenViewController: UIViewController {

    @IBOutlet var welcomeView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var welcomeScreenTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var welcomeScreenLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var welcomeScreenTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var welcomeScreenBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var firstWelcomeView: FirstWelcomeScreenView!
    @IBOutlet weak var secondWelcomeView: SecondWelcomeScreenView!
    @IBOutlet weak var loadingScreenView: LoadingScreenView!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var testErrorBtn: UIButton!
    
    
    override func viewDidLoad() {
        #if DEBUG
        textField.text = "what is the gdp and inflation of nigeria in 1999"
        #else
        testErrorBtn.isHidden = true
        #endif
        
        errorLabel.alpha = 0
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async { [self] in
                // add left padding
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
                textField.leftView = paddingView
                textField.rightView = paddingView
                textField.leftViewMode = .always
                textField.rightViewMode = .always
                
                firstWelcomeView.onContinue = {
                    self.animateToSecondWelcomeScreen()
                }
                
                // Resign first responder from textfield when screen is tapped
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
            }
        }
    }
    
    private func animateToSecondWelcomeScreen() {
        welcomeScreenLeadingConstraint.constant = 20
        welcomeScreenTrailingConstraint.constant = 20
        welcomeScreenTopConstraint.constant = 80
        welcomeScreenBottomConstraint.constant = 140
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) { [self] in
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.125, delay: 0) {
            self.firstWelcomeView.alpha = 0
            self.secondWelcomeView.alpha = 1
        } completion: {_ in
            self.firstWelcomeView.removeFromSuperview()
        }
    }
    
    private func transitionToLoadingView() {
        UIView.animate(withDuration: 0.25, delay: 0) {
            self.secondWelcomeView.alpha = 0
            self.loadingScreenView.alpha = 1
            
            self.textField.resignFirstResponder()
            self.textField.isEnabled = false
            self.textField.alpha = 0.5
            self.textField.backgroundColor = .lightGray.withAlphaComponent(0.2)
        } completion: {_ in
            self.secondWelcomeView.removeFromSuperview()
        }
        
        if let text = textField.text {
            fetchWorldBankData(forIndicator: "NY.GDP.MKTP.CD", inCountry: "USA", fromYear: "2020", toYear: "2023") { result in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let data):
                            print(data)
                        case .failure(let error):
                            print(error)
                    }
                }
            }
            
            Task {
                await extractData(from: text) { data in
                    if let data {
                        let country = data.countryName
                        let dataPoints = data.dataPoints
                        
                        DispatchQueue.main.async {
                            self.loadingScreenView.addCountryAndDataPoints(country: country, dataPoints: dataPoints.joined(separator: ","))
                            
                        }
                    } else {
                        self.transitionToErrorView()
                    }
                }
            }
        }
    }
    
    #if DEBUG
    func transitionToErrorView() {
        welcomeScreenBottomConstraint.constant = 170
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.errorLabel.alpha = 1
            self.view.layoutIfNeeded()
        } completion: { _ in
            // after 5 seconds reset the bottom constraint
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) { [self] in
                    welcomeScreenBottomConstraint.constant = 140
                    errorLabel.alpha = 0
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    #endif
    
    // Method to dismiss the keyboard
    @objc func dismissKeyboard() {
        // Dismiss the keyboard by resigning the first responder status
        view.endEditing(true)
    }

    @IBAction func onContinueTapped(_ sender: Any) {
        transitionToLoadingView()
    }
    
    @IBAction func onTestErrorTapped(_ sender: Any) {
        transitionToErrorView()
    }
}
