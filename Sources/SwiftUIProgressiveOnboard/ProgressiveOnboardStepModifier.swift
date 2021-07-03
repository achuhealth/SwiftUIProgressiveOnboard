//
//  File.swift
//  
//
//  Created by Nafeh Shoaib on 7/2/21.
//

import SwiftUI

public struct ProgressiveOnboardStepModifier: ViewModifier {
    
    @ObservedObject public var onboard: ProgressiveOnboard
    public var stepIndex: Int
    
    public var nextClosure: ProgressiveOnboard.ProgressClosure? = nil
    public var previousClosure: ProgressiveOnboard.ProgressClosure? = nil
    
    var coordinateSpace: CoordinateSpace
    
    public init(using onboard: ProgressiveOnboard, at stepIndex: Int, in coordinateSpace: CoordinateSpace = .named("OnboardSpace"), nextClosure: ProgressiveOnboard.ProgressClosure? = nil, previousClosure: ProgressiveOnboard.ProgressClosure? = nil) {
        self.onboard = onboard
        self.stepIndex = stepIndex
        self.coordinateSpace = coordinateSpace
        self.nextClosure = nextClosure
        self.previousClosure = previousClosure
    }
    
    public func body(content: Content) -> some View {
        content
            .background(ProgressiveOnboardGeometry(withRect: $onboard.filterViews[stepIndex], in: coordinateSpace))
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

public extension View {
    func setOnboardStep(using onboard: ProgressiveOnboard, at stepIndex: Int, coordinateSpace: CoordinateSpace = .named("OnboardSpace"), nextClosure: ProgressiveOnboard.ProgressClosure? = nil, previousClosure: ProgressiveOnboard.ProgressClosure? = nil) -> some View {
        return self
            .modifier(ProgressiveOnboardStepModifier(using: onboard, at: stepIndex, in: coordinateSpace, nextClosure: nextClosure, previousClosure: previousClosure))
    }
}
