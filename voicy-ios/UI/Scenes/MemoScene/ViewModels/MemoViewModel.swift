//
//  MemoViewModel.swift
//  voicy-ios
//
//  Created by Melody on 1/19/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import Foundation

class MemoViewModel {
    let networking = VoiceyHTTPClient.instance
    var memos: [Memo] = []
    var memoItems = [MemoItemViewModel]()
    
    init() {
//        fetchMemos()
        VoiceyHTTPClient.instance.request(route: .getMemo, data: nil) { (response) in
            let memoList = try? JSONDecoder().decode([Memo].self, from: response)
            self.memos = memoList!
            self.memoItems = self.getMemos(memos: self.memos)
            print(self.memoItems)
        }
        
    }
    
    func fetchMemos(callback: @escaping ([MemoItemViewModel]) -> Void) {
        VoiceyHTTPClient.instance.request(route: .getMemo, data: nil) { (response) in
            let memoList = try? JSONDecoder().decode([Memo].self, from: response)
            self.memos = memoList!
            self.memoItems = self.getMemos(memos: self.memos)
            callback(self.memoItems)
            print(self.memoItems)
        }
    }
    
    func getMemos(memos: [Memo]) -> [MemoItemViewModel] {
        return memos.map(convertToMemoItem)
    }
    
    func convertToMemoItem(memo: Memo) -> MemoItemViewModel {
        return MemoItemViewModel(
            name: "\(memo.title ?? "None")",
            content: "\(memo.text_body ?? "None")",
            time: "\(memo.date ?? "None")",
            audio: "\(memo.voice_file_url?.absoluteString ?? "None")"
        )
        
    }

}

struct MemoItemViewModel {
    let name: String
    let content: String
    let time: String
    let audio: String
    
}
