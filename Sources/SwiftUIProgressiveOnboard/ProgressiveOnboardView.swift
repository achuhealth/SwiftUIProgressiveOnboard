//
//  SwiftUIView.swift
//  
//
//  Created by Nafeh Shoaib on 7/2/21.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ProgressiveOnboardView<StepView: View>: View {
    
    @ObservedObject public var onboard: ProgressiveOnboard
    
    let stepView: StepView
    
    public init(withProgressiveOnboard onboard: ProgressiveOnboard, @ViewBuilder stepView: () -> StepView) {
        self.onboard = onboard
        self.stepView = stepView()
    }
    
    public var body: some View {
        
        Rectangle()
            .fill(Color.black)
            .opacity(0.8)
            .inverseMask(
                Rectangle()
                    .frame(width: onboard.filterView.width, height: onboard.filterView.height, alignment: .center)
                    .position(x: onboard.filterView.midX, y: onboard.filterView.midY)
                    .animation(.easeInOut(duration: onboard.animateDuration))
            )
        
        .position(x: onboard.positionX, y: onboard.positionYFixed())
        .animation(Animation.easeInOut(duration: onboard.animateDuration).delay(0.25))
    }
}

struct DefaultProgressiveOnboardStepView: View {
    @ObservedObject public var onboard: ProgressiveOnboard
    
    var body: some View {
        HStack {
            VStack {
                Text(onboard.description)
                    .padding(10)
                
                HStack {
                    if !onboard.previousButtonTitle.isEmpty {
                        Button(action: {
                            onboard.handlePrevious()
                        }, label: {
                            
                            HStack {
                                Image(systemName: "arrow.left.circle")
                                
                                Text(onboard.previousButtonTitle)
                                        .fontWeight(.semibold)
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(40)
                        })
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        onboard.handleNext()
                    }, label: {
                        
                        HStack {
                            Image(systemName: "arrow.right.circle")
                            
                            Text(onboard.nextButtonTitle)
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(40)
                    })
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding(10)
        }
    }
}


struct ProgressiveOnboardViewPreview: View {
    @StateObject var onboard = ProgressiveOnboard(withJson: "")
    
    var body: some View {
        ProgressiveOnboardView(withProgressiveOnboard: onboard) {
            DefaultProgressiveOnboardStepView(onboard: onboard)
        }
    }
}
struct ProgressiveOnboardView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressiveOnboardViewPreview()
    }
}
