//
//  AudioHandler.swift
//  voicy-ios
//
//  Created by Melody on 1/18/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import Foundation
import AVFoundation

class AudioHandler: NSObject {
    
    private var recorder: AVAudioRecorder?
    private var player: AVAudioPlayer?
    
    private let recorderSetting : [String : Any] = [
        //mp3 format
        AVFormatIDKey: kAudioFormatMPEGLayer3,
        AVEncoderAudioQualityKey: AVAudioQuality.medium
    ]
    
    private let audioOutputBasePath = try! FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false
    )
    
    private let fileExtensoin = ".mp3"
    
    /// returns - The url of the temporary location where the recording will be stored
    func prepareRecorder() -> URL {
        //Create an unique id for audio file
        let fileName = UUID().uuidString
        
        let outputFileURL = audioOutputBasePath.appendingPathComponent(fileName).appendingPathExtension(fileExtensoin)
        guard let recorder = try? AVAudioRecorder(
            url: outputFileURL,
            settings: recorderSetting
            ) else {return outputFileURL}
        
        self.recorder = recorder
        recorder.delegate = self
        recorder.prepareToRecord()
        return outputFileURL
    }
    
    func startRecording() {
        recorder?.record()
    }
    
    func stopRecording() {
        recorder?.stop()
    }
    
    func playAudio(voiceURL: URL) {
        player = try? AVAudioPlayer(contentsOf: voiceURL)
        player?.play()
    }
    
    func stopAudio() {
        player?.stop()
    }
}

extension AudioHandler: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    }
   
}
