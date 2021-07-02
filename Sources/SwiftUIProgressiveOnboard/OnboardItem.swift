//
//  File.swift
//  
//
//  Created by Nafeh Shoaib on 7/2/21.
//

import Foundation

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct OnboardItem: Codable {
    public var description: String
    public var nextButtonTitle: String
    public var previousButtonTitle: String
    
    public init(description: String, previousButtonTitle: String, nextButtonTitle: String) {
        self.description = description
        self.nextButtonTitle = nextButtonTitle
        self.previousButtonTitle = previousButtonTitle
    }
}
