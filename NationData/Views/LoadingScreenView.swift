//
//  LoadingScreenView.swift
//  NationData
//
//  Created by Christopher Inegbedion on 26/08/2024.
//

import UIKit

class LoadingScreenView: UIView {
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var dataPointsLabel: UILabel!
    @IBOutlet weak var dividerImage: UIImageView!
    
    // This method will load the view from the .xib file
    private func loadViewFromNib() -> UIView? {
        guard let nibViews = Bundle.main.loadNibNamed("LoadingScreenView", owner: self, options: nil) as? [UIView] else {
            return nil
        }
        
        let firstView = nibViews.first(where: { $0.restorationIdentifier == "loadingScreenView" })
        
        firstView?.layer.cornerRadius = 20
        firstView?.layer.borderWidth = 0.5
        firstView?.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        dataPointsLabel.alpha = 0
        dividerImage.alpha = 0
        countryName.alpha = 0
        
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
    
    func addCountryAndDataPoints(country: String, dataPoints: String) {
        countryName.text = country
        dataPointsLabel.text = dataPoints
        
        UIView.animate(withDuration: 0.5) { [self] in
            dataPointsLabel.alpha = 1
            countryName.alpha = 1
            dividerImage.alpha = 1
        }
    }
}
