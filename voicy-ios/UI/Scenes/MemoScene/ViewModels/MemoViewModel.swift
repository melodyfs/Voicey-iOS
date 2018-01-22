//
//  MemoViewModel.swift
//  voicy-ios
//
//  Created by Melody on 1/19/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import Foundation

struct MemoViewModel {
    let networking = VoiceyHTTPClient.instance
    var memos: [Memo] = []
    
    init() {
        networking.request { (response) in
            
        }
    }
    
    func getMemos(memos: [Memo]) -> [MemoItemViewModel] {
        return memos.map(convertToMemoItem)
    }
    
    func convertToMemoItem(memo: Memo) -> MemoItemViewModel {
        return MemoItemViewModel(name: "@\(memo.title ?? "None")")
    }
}

struct MemoItemViewModel {
    let name: String
//    let content: String
    
}
