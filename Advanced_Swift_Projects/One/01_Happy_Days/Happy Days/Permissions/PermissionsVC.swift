//
//  PermissionsVC.swift
//  Happy Days
//
//  Created by tarrask on 22/06/2021.
//

import Foundation
import AVFoundation
import Photos
import Speech

final class PermissionsVC {
    var authorized: Bool { photosAuthorized && recordingAuthorized && transcribeAuthorized }
    
    private var photosAuthorized = false
    private var recordingAuthorized = false
    private var transcribeAuthorized = false
    
    func requestPermissions() {
        PHPhotoLibrary.requestAuthorization{ [unowned self] authStatus in
            if authStatus == .authorized {
                photosAuthorized = true
            } else {
                print("photo usage not authorized")
            }
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission() { [unowned self] allowed in
            if allowed {
                recordingAuthorized = true
            } else {
                print("photo usage not authorized")
            }
        }
        
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
            if authStatus == .authorized {
                transcribeAuthorized = true
            } else {
                print("photo usage not authorized")
            }
        }
    }
    
    func checkPermissions() -> Bool {
        // check status for all three permissions
        photosAuthorized = PHPhotoLibrary.authorizationStatus() == .authorized
        recordingAuthorized = AVAudioSession.sharedInstance().recordPermission == .granted
        transcribeAuthorized = SFSpeechRecognizer.authorizationStatus() == .authorized
        
        return authorized
    }
}
