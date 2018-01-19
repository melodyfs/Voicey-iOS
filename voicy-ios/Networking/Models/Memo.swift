//
//  Memo.swift
//  voicy-ios
//
//  Created by Melody on 1/18/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import Foundation

struct Memo: Codable {
    var title: String?
    var text_body: String?
    var date: Date?
    var voice_file_url: URL?
}
