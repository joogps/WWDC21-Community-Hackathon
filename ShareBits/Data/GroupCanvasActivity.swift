//
//  GroupCanvasActivity.swift
//  ShareBits
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import Foundation
import GroupActivities

struct GroupCanvasActivity: GroupActivity {
    let name: String
    
    static var activityIdentifier = "com.rcsbnu.ShareBits.GroupCanvas"
    
    var metadata: GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.title = name
        metadata.type = .generic
        return metadata
    }
}
