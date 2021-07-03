//
//  File.swift
//  
//
//  Created by Nafeh Shoaib on 7/2/21.
//

import Foundation

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct OnboardItem: Codable {
    public var title: String
    public var description: String
    public var imageName: String?
    public var nextButtonTitle: String
    public var previousButtonTitle: String
    
    public init(title: String = "", description: String, imageName: String? = nil, previousButtonTitle: String, nextButtonTitle: String) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.nextButtonTitle = nextButtonTitle
        self.previousButtonTitle = previousButtonTitle
    }
}
