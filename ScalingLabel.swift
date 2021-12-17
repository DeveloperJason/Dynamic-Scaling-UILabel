//
//  ScalingLabel.swift
//
//  Created by Jason Philpy on 4/30/18.

import UIKit

class ScalingLabel: UILabel {
    
    private var originalFontSize:CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        setOriginalFontSize()

        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: OperationQueue.main) { (notification) in
            self.font = UIFont(descriptor: self.font.fontDescriptor, size: self.originalFontSize * self.fontSizeMultiplier)
        }
        self.font = UIFont(descriptor: self.font.fontDescriptor, size: originalFontSize * fontSizeMultiplier)
    }
    
    private var fontSizeMultiplier : CGFloat {
        get {
            switch UIApplication.shared.preferredContentSizeCategory {
            case UIContentSizeCategory.accessibilityExtraExtraExtraLarge: return 9 / 5
            case UIContentSizeCategory.accessibilityExtraExtraLarge: return 17 / 10
            case UIContentSizeCategory.accessibilityExtraLarge: return 8 / 5
            case UIContentSizeCategory.accessibilityLarge: return 3 / 2
            case UIContentSizeCategory.accessibilityMedium: return 7 / 5
            case UIContentSizeCategory.extraExtraExtraLarge: return 13 / 10
            case UIContentSizeCategory.extraExtraLarge: return 6 / 5
            case UIContentSizeCategory.extraLarge: return 11 / 10
            case UIContentSizeCategory.large: return 1.0
            case UIContentSizeCategory.medium: return 9 / 10
            case UIContentSizeCategory.small: return 4 / 5
            case UIContentSizeCategory.extraSmall: return 7 / 10
            default: return 1.0
            }
        }
    }
    
    private func setOriginalFontSize() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            originalFontSize = self.font.fontDescriptor.pointSize * 1.5
        } else {
            originalFontSize = self.font.fontDescriptor.pointSize
        }
    }
    
    override var font: UIFont! {
        didSet {
            setOriginalFontSize()
        }
    }
}
