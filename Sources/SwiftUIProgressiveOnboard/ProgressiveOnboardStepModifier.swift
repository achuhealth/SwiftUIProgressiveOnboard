//
//  File.swift
//  
//
//  Created by Nafeh Shoaib on 7/2/21.
//

import SwiftUI

struct ProgressiveOnboardStepModifier: ViewModifier {
    
    @ObservedObject public var onboard: ProgressiveOnboard
    public var stepIndex: Int
    
    public var nextClosure: ProgressiveOnboard.ProgressClosure? = nil
    public var previousClosure: ProgressiveOnboard.ProgressClosure? = nil
    
    public init(using onboard: ObservedObject<ProgressiveOnboard>, at stepIndex: Int, nextClosure: ProgressiveOnboard.ProgressClosure? = nil, previousClosure: ProgressiveOnboard.ProgressClosure? = nil) {
        self._onboard = onboard
        self.stepIndex = stepIndex
        self.nextClosure = nextClosure
        self.previousClosure = previousClosure
    }
    
    func body(content: Content) -> some View {
        content
            .background(ProgressiveOnboardGeometry(withRect: $onboard.filterViews[stepIndex]))
            .onAppear {
                DispatchQueue.main.async {
                    if let nextClosure = nextClosure {
                        onboard.nextClosures[stepIndex] = nextClosure
                    }
                    if let previousClosure = previousClosure {
                        onboard.previousClosures[stepIndex] = previousClosure
                    }
                }
            }
    }
}
