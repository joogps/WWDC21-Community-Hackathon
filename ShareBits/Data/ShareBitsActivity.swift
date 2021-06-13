//
//  ShareBitsActivity.swift
//  ShareBits
//
//  Created by João Gabriel Pozzobon dos Santos on 12/06/21.
//

import Foundation
import GroupActivities

struct ShareBitsActivity: GroupActivity {
    var metadata: GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.title = "Group canvas"
        metadata.type = .generic
        return metadata
    }
}
