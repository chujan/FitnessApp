//
//  VideoViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 03/01/2024.
//

import UIKit
import AVKit

class VideoViewController: UIViewController {

    private let playerViewController: AVPlayerViewController

    init(videoURL: URL) {
        self.playerViewController = AVPlayerViewController()
        super.init(nibName: nil, bundle: nil)
        configurePlayer(with: videoURL)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayerView()
    }

    private func configurePlayer(with videoURL: URL) {
        let player = AVPlayer(url: videoURL)
        playerViewController.player = player

        // Add observer for playback completion
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(_:)),
                                               name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)

        // Add observer for playback failure
        NotificationCenter.default.addObserver(self, selector: #selector(playerFailedToPlayToEndTime(_:)),
                                               name: .AVPlayerItemFailedToPlayToEndTime, object: player.currentItem)
    }

    private func setupPlayerView() {
        addChild(playerViewController)
        view.addSubview(playerViewController.view)
        playerViewController.view.frame = view.bounds
        playerViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerViewController.didMove(toParent: self)
    }

    // Observer method for successful playback completion
    @objc private func playerDidFinishPlaying(_ notification: Notification) {
        print("Video playback completed.")
    }

    // Observer method for playback failure
    @objc private func playerFailedToPlayToEndTime(_ notification: Notification) {
        if let error = notification.userInfo?[AVPlayerItemFailedToPlayToEndTimeErrorKey] as? Error {
            print("Video playback failed with error: \(error.localizedDescription)")
        }
    }

    // Deinitialize and remove observers
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}



//class VideoViewController: UIViewController {
//    override func viewDidLoad() {
//          super.viewDidLoad()
//
//
//          // Call this method when you want to play the video programmatically
//          playVideo()
//      }
//
//      func playVideo() {
//          // play video connected to the button
//          guard let videoPath = Bundle.main.path(forResource: "pushUp", ofType: "mp4") else {
//              debugPrint("Video not found")
//              return
//          }
//
//          // Create an AVPlayer, passing it the video URL
//          let player = AVPlayer(url: URL(fileURLWithPath: videoPath))
//
//          // Create a new AVPlayerViewController and pass it a reference to the player.
//          let playerController = AVPlayerViewController()
//          playerController.player = player
//
//          playerController.showsPlaybackControls = true
//
//          // Add an observer for closing when the video ends
//          NotificationCenter.default.addObserver(self, selector: #selector(closePlayer), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
//
//          // Add a gesture recognizer for closing on tap
//          let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closePlayer))
//          playerController.view.addGestureRecognizer(tapGestureRecognizer)
//
//          // Modally present the player and call the player's play() method when complete.
//          present(playerController, animated: true) {
//              player.play()
//          }
//      }
//
//      @objc func closePlayer() {
//          dismiss(animated: true)
//          // If you go the notification route, don't forget to remove the observer
//          NotificationCenter.default.removeObserver(self)
//      }
//
//
//
//
//}
//
////        let layer = AVPlayerLayer(player: player)
////        layer.frame = view.bounds
////        layer.videoGravity = .resizeAspectFill
////        view.layer.addSublayer(layer)
////        player.play()
//
