//
//  PermissionsController.swift
//  Happy Days
//
//  Created by Alex Luna on 16/06/2021.
//

import Foundation
import AVFoundation
import Photos
import Speech

class PermissionsController: ObservableObject {
    static var canProcceed: Bool {
        let photosAuthorized = PHPhotoLibrary.authorizationStatus() == .authorized
        let recordingAuthorized = AVAudioSession.sharedInstance().recordPermission == .granted
        let transcribeAuthorized = SFSpeechRecognizer.authorizationStatus() == .authorized
        // make a single boolean out of all three
        return photosAuthorized && recordingAuthorized && transcribeAuthorized
    }

    func requestPermissions() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
        }

        AVAudioSession.sharedInstance().requestRecordPermission() { allowed in
        }

        SFSpeechRecognizer.requestAuthorization { authStatus in
        }
    }
}
