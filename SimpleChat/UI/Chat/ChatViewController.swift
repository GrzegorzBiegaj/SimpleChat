//
//  ChatViewController.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 13.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit
import AVKit

class ChatViewController: UIViewController {

    let leftTextCellName = "LeftTextCellRI"
    let rightTextCellName = "RightTextCellRI"
    let leftVideoCellName = "LeftVideoCellRI"
    let rightVideoCellName = "RightVideoCellRI"

    // MARK: - Controllers

    let viewModel = ChatViewModel()

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = .silverGrey
    }

    func reloadData() {
        tableView.reloadData()
        scrollTable(animated: true)
    }

    func scrollTable(animated: Bool) {
        let numberOfSections = tableView.numberOfSections
        let numberOfRows = tableView.numberOfRows(inSection: numberOfSections - 1)

        if numberOfRows > 0 {
            let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfSections - 1)
            tableView.scrollToRow(at: indexPath, at: .middle, animated: animated)
        }
    }

    func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player

        present(vc, animated: true) {
            vc.player?.play()
        }
    }

}

// MARK: - Tableview data source

extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chats.chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.chats.chats[indexPath.row]

        var cellName = ""
        if case .text = message.message.entry {
            cellName = message.message.side == .received ? leftTextCellName : rightTextCellName
        } else {
            cellName = message.message.side == .received ? leftVideoCellName : rightVideoCellName
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)

        if case .text = message.message.entry, let cell = cell as? ChatTextTableViewCell {
            cell.message = message
        }
        if case .movie = message.message.entry, let cell = cell as? ChatVideoTableViewCell {
            cell.message = message
            cell.delegate = self
        }
        return cell
    }

}

// MARK: - Tableview delegate

extension ChatViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ChatVideoTableViewCellProtocol

extension ChatViewController: ChatVideoTableViewCellProtocol {
    func playButtonPressed(url: URL) {
        playVideo(url: url)
    }
    

}
