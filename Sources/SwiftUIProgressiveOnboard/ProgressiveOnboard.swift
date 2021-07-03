//
//  File.swift
//  
//
//  Created by Nafeh Shoaib on 7/2/21.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public class ProgressiveOnboard: ObservableObject {
    public typealias ProgressClosure = (@escaping () -> Void) -> Void
    
    @Published public var showOnboardScreen = false
    @Published public var activeIndex = 0
    
    internal var animateDuration: Double = 0.5
    
    internal var onboardItems = [OnboardItem]()
    public var filterViews = [CGRect]()
    
    public var nextClosures = [Int: ProgressClosure]()
    public var previousClosures = [Int: ProgressClosure]()
    
    public init(withJson json: String, animateDuration: Double? = nil) {
        setup(withJson: json)
        if let animateDuration = animateDuration {
            self.animateDuration = animateDuration
        }
    }
    
    public init(withItems onboardItems: [OnboardItem], animateDuration: Double? = nil, nextClosures: [Int: ProgressClosure] = [:], previousClosures: [Int: ProgressClosure] = [:]) {
        setup(withItems: onboardItems)
        
        if let animateDuration = animateDuration {
            self.animateDuration = animateDuration
        }
        
        self.nextClosures = nextClosures
        self.previousClosures = previousClosures
    }
    
    private func setup(withItems onboardItems: [OnboardItem]) {
        self.onboardItems = onboardItems
        filterViews = onboardItems.map { _ in CGRect(x: 0, y: UIScreen.main.bounds.midY, width: 0, height: 0) }
    }
    
    private func setup(withJson json: String) {
        do {
            let data = json.data(using: .utf8)
            let decoder = JSONDecoder()
            onboardItems = try decoder.decode([OnboardItem].self, from: data!)
            
            for _ in 0..<onboardItems.count {
                filterViews.append(CGRect())
            }
        } catch {
            print("error:\(error)")
        }
    }
    
    public func handlePrevious() {
        var newIndex = activeIndex
        if activeIndex > 0 {
            newIndex -= 1
        }
        
        if let closure = previousClosures[newIndex] {
            closure { [self] in
                activeIndex = newIndex
            }
        } else {
            activeIndex = newIndex
        }
    }
    
    public func handleNext() {
        var newIndex = activeIndex
        var endScreens = false
        
        if activeIndex+1 == onboardItems.count {
            // End onboard screens
            newIndex = 0
            endScreens = true
        } else {
            newIndex += 1
        }
        
        let setIndex = { [self] in
            activeIndex = newIndex
            if endScreens {
                showOnboardScreen = false
            }
        }
        
        if let closure = nextClosures[newIndex] {
            closure {
                setIndex()
            }
        } else {
            setIndex()
        }
    }
    
    internal var filterView: CGRect {
        return filterViews[activeIndex]
    }
    
    public var title: String {
        return onboardItems[activeIndex].title
    }
    
    public var description: String {
        return onboardItems[activeIndex].description
    }
    
    public var imageName: String? {
        return onboardItems[activeIndex].imageName
    }
    
    public var nextButtonTitle: String {
        return onboardItems[activeIndex].nextButtonTitle
    }
    
    public var previousButtonTitle: String {
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
