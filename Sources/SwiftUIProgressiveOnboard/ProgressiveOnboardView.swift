//
//  SwiftUIView.swift
//  
//
//  Created by Nafeh Shoaib on 7/2/21.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ProgressiveOnboardView: View {
    
    @ObservedObject public var onboard: ProgressiveOnboard
    
    public init(withProgressiveOnboard: ProgressiveOnboard) {
        self.onboard = withProgressiveOnboard
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
        .position(x: onboard.positionX, y: onboard.positionYFixed())
        .animation(Animation.easeInOut(duration: onboard.animateDuration).delay(0.25))
    }
}

struct ProgressiveOnboardView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressiveOnboardView(withProgressiveOnboard: .init(withJson: ""))
    }
}
