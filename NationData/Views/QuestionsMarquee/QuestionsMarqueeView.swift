//
//  QuestionsMarqueeView.swift
//  NationData
//
//  Created by Christopher Inegbedion on 24/08/2024.
//

import UIKit
import SwiftUI

class QuestionsMarqueeView: UIView {

    private func setupView() {
        let questionMarqueeView = QuestionsMarquee()
        let hostingController = UIHostingController(rootView: questionMarqueeView)
        
        if let view = hostingController.view {
            view.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(view)
            view.backgroundColor = .clear
            
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: topAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }

}
