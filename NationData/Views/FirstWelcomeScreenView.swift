//
//  FirstWelcomeScreenView.swift
//  NationData
//
//  Created by Christopher Inegbedion on 23/08/2024.
//

import UIKit

@IBDesignable
class FirstWelcomeScreenView: UIView {
    
    var onContinue: (() -> Void)?
    
    // This method will load the view from the .xib file
    private func loadViewFromNib() -> UIView? {
        guard let nibViews = Bundle.main.loadNibNamed("FirstWelcomeScreenView", owner: self, options: nil) as? [UIView] else {
            return nil
        }
        
        let firstView = nibViews.first(where: { $0.restorationIdentifier == "first" })
        
        return firstView
    }
    
    // This method will set up the view after loading
    private func setupView() {
        guard let contentView = loadViewFromNib() else {
            return
        }
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    // Override the init methods to call setupView
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    @IBAction func onContinueTapped(_ sender: Any) {
        if let onContinue = onContinue {
            onContinue()
        }
    }
}
