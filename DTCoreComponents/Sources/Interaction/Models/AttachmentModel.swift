//
//  AttachmentModel.swift
//  DTCoreComponents
//
//  Created by Максим Евтух on 09.03.2021.
//  Copyright © 2021 DreamTeam. All rights reserved.
//

import Foundation

public struct AttachmentModel {
    
    public let data: Data
    public let mimeType: String
    public let fileName: String
    
    public init(data: Data, mimeType: String, fileName: String) {
        self.data = data
        self.mimeType = mimeType
        self.fileName = fileName
    }
    
}
