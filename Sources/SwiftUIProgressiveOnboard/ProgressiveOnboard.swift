//
//  File.swift
//  
//
//  Created by Nafeh Shoaib on 7/2/21.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public class ProgressiveOnboard: ObservableObject {
    @Published public var showOnboardScreen = false
    @Published private var activeIndex = 0
    
    internal var animateDuration: Double = 0.5
    
    internal var onboardItems = [OnboardItem]()
    public var filterViews = [CGRect]()
    
    public init(withJson: String) {
        setup(withJson: withJson)
    }
    
    public init(withJson: String, animateDuration: Double) {
        setup(withJson: withJson)
        self.animateDuration = animateDuration
    }
    
    private func setup(withJson: String) {
        do {
            let data = withJson.data(using: .utf8)
            let decoder = JSONDecoder()
            onboardItems = try decoder.decode([OnboardItem].self, from: data!)
            
            for _ in 0..<onboardItems.count {
                filterViews.append(CGRect())
            }
        } catch {
            print("error:\(error)")
        }
    }
    
    internal func handlePrevious() {
        if activeIndex > 0 {
            activeIndex -= 1
        }
    }
    
    internal func handleNext() {
        if activeIndex+1 == onboardItems.count {
            // End onboard screens
            activeIndex = 0
            self.showOnboardScreen = false
        } else {
            activeIndex += 1
        }
    }
    
    internal var filterView: CGRect {
        return filterViews[activeIndex]
    }
    
    internal var description: String {
        return onboardItems[activeIndex].description
    }
    
    internal var nextButtonTitle: String {
        return onboardItems[activeIndex].nextButtonTitle
    }
    
    internal var previousButtonTitle: String {
        return onboardItems[activeIndex].previousButtonTitle
    }
    
    internal var positionX: CGFloat {
        return UIScreen.main.bounds.midX
    }
    
    internal func positionY(contentView: CGRect) -> CGFloat {
        if filterView.maxY + contentView.height > UIScreen.main.bounds.size.height {
            return filterView.minY - contentView.height/2
        } else {
            return filterView.maxY + contentView.height/2
        }
    }
    
    internal func positionYFixed() -> CGFloat {
        let fixedHeight: CGFloat = 200.0
        if filterView.maxY + fixedHeight > UIScreen.main.bounds.size.height {
            return filterView.minY - fixedHeight/2
        } else {
            return filterView.maxY + fixedHeight/2
        }
    }
}
