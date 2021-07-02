//
//  File.swift
//  
//
//  Created by Nafeh Shoaib on 7/2/21.
//

import SwiftUI

extension View {
    public func setProgressiveOnboardStep(using onboard: Binding<ProgressiveOnboard>, at stepIndex: Int, nextClosure: ProgressiveOnboard.ProgressClosure? = nil, previousClosure: ProgressiveOnboard.ProgressClosure? = nil) -> some View {
        return self
            .background(ProgressiveOnboardGeometry(withRect: onboard.filterViews[stepIndex]))
            .onAppear {
                DispatchQueue.main.async {
                    if let nextClosure = nextClosure {
                        onboard.nextClosures.wrappedValue[stepIndex] = nextClosure
                    }
                    if let previousClosure = previousClosure {
                        onboard.previousClosures.wrappedValue[stepIndex] = previousClosure
                    }
                }
            }
    }
    
}
