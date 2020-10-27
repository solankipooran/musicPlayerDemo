//
//  ViewController.swift
//  musicplayer
//
//  Created by POORAN SUTHAR on 02/03/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    
    @IBOutlet weak var volumnvalue: UISlider!
    @IBOutlet weak var songSlider: UISlider!
    
    @IBAction func songlevelSlider(_ sender: Any) {
        player?.currentTime = TimeInterval(songSlider.value)
        //        songcurrentlocationlbl.text = String(player!.currentTime)
    }
    
    @IBAction func volumnSlider(_ sender: Any) {
        if player != nil{
            player?.volume = volumnvalue.value
        }
    }
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var playbutton: UIButton!
    @IBOutlet weak var artworklbl: UILabel!
    @IBOutlet weak var artistlabel: UILabel!
    @IBOutlet weak var songlabel: UILabel!
    
    var player : AVAudioPlayer?
    let music = ["Genda Phool - Badshah","Masakali 2 - Sachet Tandon" ]
    var currentsong = 0
    var isPause = false
    var startSong = 0
    let volumnView = MPVolumeView()
    var nowPlayingInfo : [String : Any] = [:]
    let audioInfo = MPNowPlayingInfoCenter.default()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func previousbutton(_ sender: Any) {
        currentsong = currentsong - 1
        if currentsong < 0{
            currentsong = 1
        }
        songlabelchange()
        playSong()
    }
    @IBAction func playbutton(_ sender: Any) {
        
        if player?.isPlaying ??  false {
            let pauseimage = UIImage(named: "pause")
            playbutton.setBackgroundImage(pauseimage, for: .normal)
            player?.pause()
            isPause = true
        }else{
            let image = UIImage(named: "play")
            playbutton.setBackgroundImage(image, for: .normal)
            if isPause {
                player!.play()
            } else {
                playSong()
            }
            songlabelchange()
        }
        
    }
    @IBAction func nextbutton(_ sender: Any) {
        currentsong = currentsong + 1
        if currentsong > 1{
            currentsong = 0
        }
        songlabelchange()
        playSong()
    }
    func playSong(){
        
        if let url = Bundle.main.url(forResource: music[currentsong], withExtension: "mp3"){
            do{
                try AVAudioSession.sharedInstance().setCategory(.playback , options: .defaultToSpeaker)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//              fetchsogInfo(url: url)
//              audioInfo.nowPlayingInfo = nowPlayingInfo
                player?.prepareToPlay()
                songSlider.maximumValue = Float( player!.duration)
                songSlider.value = 0.0
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updatetimer), userInfo: nil, repeats: true)
                player?.play()
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
        
        
    }
    func songlabelchange(){
        songlabel.text = music[currentsong]
    }
    
    @objc  func updatetimer(timer :Timer){
        let updater = Float(player!.currentTime)
        songSlider.setValue(updater, animated: true)
    }
    
//    func fetchsogInfo(url : URL){
//        let playerItem = AVPlayerItem(url: url)
//        let metadataList = playerItem.asset.metadata
//        for item in metadataList{
//            if item.commonKey != nil && item.value != nil {
//                if item.commonKey == "title" {
//                    nowPlayingInfo[MPMediaItemPropertyTitle] = item.stringValue
//                }
//                if item.commonKey   == "type" {
//                    nowPlayingInfo[MPMediaItemPropertyGenre] = item.stringValue
//                }
//                if item.commonKey  == "artist" {
//                    nowPlayingInfo[MPMediaItemPropertyArtist] = item.stringValue
//                }
//                if item.commonKey  == "artwork" {
//                    if let image = UIImage(data: item.value as! Data) {
//                        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(image: image)
//                    }
//                }
//            }
//        }
//    }
    
    
}

