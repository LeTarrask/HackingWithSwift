//
//  MemoriesVC.swift
//  Happy Days
//
//  Created by tarrask on 22/06/2021.
//

import SwiftUI
import Speech
import AVFoundation

class MemoriesVC: ObservableObject {
    @Published var memories = [Memory]()
    
    private var audioRecorder: AVAudioRecorder?
    private var recordingURL: URL {
        getDocumentsDirectory().appendingPathComponent("recording.m4a")
    }
    
    let fm = FileManager.default
    
    var activeMemory: Memory?
    
    var audioPlayer: AVAudioPlayer?
    
    init() {
        loadMemories()
    }
    
    func playAudio(from url: URL) {
        if fm.fileExists(atPath: url.path) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("error loading audio")
            }
        }
    }
    
    func startRecording() {
        audioPlayer?.stop()
        
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            // 2. configure the session for recording and playback through the speaker
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try recordingSession.setActive(true)
            // 3. set up a high-quality recording session
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            // 4. create the audio recording, and assign ourselves as the delegate
            audioRecorder = try AVAudioRecorder(url: recordingURL, settings: settings)
            audioRecorder?.record()
            
        } catch let error {
            // failed to record!
            print("Failed to record: \(error)")
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        // should stop recording audio
        audioRecorder?.stop()
        
        if success {
            // call to transcribe
            do {
                // 4
                guard let active = activeMemory else { return }
                
                if fm.fileExists(atPath: active.audioURL().path) {
                    try fm.removeItem(at: active.audioURL())
                }
                
                // 5
                try fm.moveItem(at: recordingURL, to: active.audioURL())
                
                // 6
                guard fm.fileExists(atPath: activeMemory!.audioURL().path) else { return }
                transcribeAudio(memory: activeMemory!)
                
            } catch let error {
                print("Failure finishing recording: \(error)")
            }
        }
    }
    
    func transcribeAudio(memory: Memory) {
        // get paths to where the audio is, and where the transcription should be
        let audio = memory.audioURL()
        let transcription = memory.transcriptionURL()
        
        // create a new recognizer and point it at our audio
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: audio)
        
        // start recognition!
        recognizer?.recognitionTask(with: request) { [unowned self] (result, error) in
            // abort if we didn't get any transcription back
            guard let result = result else {
                print("There was an error: \(error!)")
                return
            }
            
            // if we got the final transcription back, we need to write it to disk
            if result.isFinal {
                // pull out the best transcription...
                let text = result.bestTranscription.formattedString
                // ...and write it to disk at the correct filename for this memory.
                
                do {
                    try text.write(to: transcription, atomically: true, encoding: String.Encoding.utf8)
                } catch {
                    print("Failed to save transcription.")
                }
            }
        }
    }
    
    func setActiveMemory(_ memory: Memory) {
        guard let index = memories.firstIndex(of: memory)  else { return }
        activeMemory = memories[index]
    }
    
    func addImage(_ image: UIImage) {
        // create a unique name for this memory
        let memoryName = "memory-\(Date().timeIntervalSince1970)"
        // use the unique name to create filenames for the full-size image and the thumbnail
        let imageName = memoryName + ".jpg"
        let thumbnailName = memoryName + ".thumb"
        do {
            // create a URL where we can write the JPEG to
            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
            // convert the UIImage into a JPEG data object
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                // write that data to the URL we created
                try jpegData.write(to: imagePath, options: [.atomicWrite])
            }
            // create thumbnail here
            if let thumbnail = resize(image: image, to: 200) {
                let imagePath = getDocumentsDirectory().appendingPathComponent(thumbnailName)
                if let jpegData = thumbnail.jpegData(compressionQuality: 0.8) {
                    try jpegData.write(to: imagePath, options: [.atomicWrite])
                }
            }
            
            // add image URL to memories
            let memory = Memory(url: getDocumentsDirectory().appendingPathComponent(memoryName))
            memories.append(memory)
        } catch {
            print("Failed to save to disk.")
        }
    }
    
    func loadMemories() {
        memories.removeAll()
        // attempt to load all the memories in our documents directory
        guard let files = try? FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: nil, options: []) else { return }
        // loop over every file found
        for file in files {
            let filename = file.lastPathComponent
            // check it ends with ".thumb" so we don't count each memory more than once
            if filename.hasSuffix(".thumb") {
                // get the root name of the memory (i.e., without its path extension)
                let noExtension = filename.replacingOccurrences(of: ".thumb", with: "")
                // create a full path from the memory
                let memoryPath = getDocumentsDirectory().appendingPathComponent(noExtension)
                // add it to our array
                let memory = Memory(url: memoryPath)
                memories.append(memory)
            }
        }
    }
    
    private func resize(image: UIImage, to width: CGFloat) -> UIImage? {
        // calculate how much we need to bring the width down to match our target size
        let scale = width / image.size.width
        
        // bring the height down by the same amount so that the aspect ratio is preserved
        let height = image.size.height * scale
        
        // create a new image context we can draw into
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        
        // draw the original image into the context
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        // pull out the resized version
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end the context so UIKit can clean up
        UIGraphicsEndImageContext()
        
        // send it back to the caller
        return newImage
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}


