//
//  File.swift
//  
//
//  Created by Nafeh Shoaib on 7/2/21.
//

import Foundation

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct OnboardItem: Decodable {
    internal var description: String
    internal var nextButtonTitle: String
    internal var previousButtonTitle: String
    
    public init(description: String, previousButtonTitle: String, nextButtonTitle: String) {
        self.description = description
        self.nextButtonTitle = nextButtonTitle
        self.previousButtonTitle = previousButtonTitle
    }
    
    private enum CodingKeys: String, CodingKey {
        case description, nextButtonTitle, previousButtonTitle
    }
}
