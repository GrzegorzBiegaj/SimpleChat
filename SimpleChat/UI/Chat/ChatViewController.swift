//
//  ChatViewController.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 13.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    let leftTextCellName = "LeftTextCellRI"
    let rightTextCellName = "RightTextCellRI"

    // MARK: - Controllers

    let viewModel = ChatViewModel()

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = .silverGrey
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        scrollTable(animated: false)
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

}

// MARK: - Tableview data source

extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chats.chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.chats.chats[indexPath.row]

        let cellName = message.message.side == .received ? leftTextCellName : rightTextCellName
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        if let cell = cell as? ChatTableViewCell {
            cell.message = message
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
