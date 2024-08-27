//
//  SecondWelcomeScreenView.swift
//  NationData
//
//  Created by Christopher Inegbedion on 23/08/2024.
//

import UIKit

class SecondWelcomeScreenView: UIView {
    
    // This method will load the view from the .xib file
    private func loadViewFromNib() -> UIView? {
        guard let nibViews = Bundle.main.loadNibNamed("SecondWelcomeScreenView", owner: self, options: nil) as? [UIView] else {
            return nil
        }
        
        let firstView = nibViews.first(where: { $0.restorationIdentifier == "second" })
        
        firstView?.layer.cornerRadius = 20
        firstView?.layer.borderWidth = 0.5
        firstView?.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        return firstView
    }
    
    // This method will set up the view after loading
    private func setupView() {
        guard let contentView = loadViewFromNib() else { return }
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
    
    
}
