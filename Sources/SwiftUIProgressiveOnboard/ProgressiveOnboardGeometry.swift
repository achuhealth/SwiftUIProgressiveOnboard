//
//  File.swift
//  
//
//  Created by Nafeh Shoaib on 7/2/21.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ProgressiveOnboardGeometry: View {
    @Binding public var rect: CGRect
    
    public init(withRect rect: Binding<CGRect>) {
        self._rect = rect
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                DispatchQueue.main.async {
                    self.rect = geometry.frame(in: .named("OnboardSpace"))
                }

                return AnyView(Color.clear)
            }
        }
    }
}
