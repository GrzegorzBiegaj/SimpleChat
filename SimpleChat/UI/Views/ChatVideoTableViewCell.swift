//
//  ChatVideoTableViewCell.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 15.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit
import AVFoundation

protocol ChatVideoTableViewCellProtocol: class {
    func playButtonPressed(url: URL)
}

class ChatVideoTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!

    // MARK: - Actions
    @IBAction func onPlayButtonTap(_ sender: UIButton) {
        guard let url = url else { return }
        delegate?.playButtonPressed(url: url)
    }

    weak var delegate: ChatVideoTableViewCellProtocol?

    // MARK: - Properties

    private(set) var url: URL?
    var message: MessageVM? {

        didSet {
            guard let message = message, case .video(let url) = message.message.entry else { return }

            avatarView.avatar = message.avatar
            timestampLabel.textColor = .black
            timestampLabel.text = message.time
            backgroundColor = .silverGrey
            self.url = url

            DispatchQueue.global().async {
                let asset = AVAsset(url: url)
                let assetImgGenerate = AVAssetImageGenerator(asset: asset)
                assetImgGenerate.appliesPreferredTrackTransform = true
                let time = CMTimeMake(1, 2)
                let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                guard let newImage = img else { return }
                let frameImg = UIImage(cgImage: newImage)
                guard self.url == url else { return }
                DispatchQueue.main.async(execute: {
                    self.videoImageView.image = frameImg
                })
            }
        }
    }

}
