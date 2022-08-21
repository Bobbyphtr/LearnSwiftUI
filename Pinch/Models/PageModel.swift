//
//  PageModel.swift
//  Pinch
//
//  Created by Bobby Pehtrus on 21/08/22.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName : String
    
    var thumbnailName: String {
        "thumb-" + imageName
    }
}
