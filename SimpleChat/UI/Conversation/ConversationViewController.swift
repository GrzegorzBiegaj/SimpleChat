//
//  ConversationViewController.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 13.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import UIKit
import MobileCoreServices

class ConversationViewController: UIViewController {

    let chatViewControllerName = "ChatViewController"

    // MARK: - View Models, Controllers

    let viewModel = ConversationViewModel()
    let chatViewModel = ChatViewModel()
    let webSocketController = WebSocketController.shared

    lazy var videoPicker = UIImagePickerController()
    
    // MARK: - Outlets

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageEditorTextField: UITextField!
    @IBOutlet weak var editorBottomConstraint: NSLayoutConstraint!
    weak var chatViewController: ChatViewController?

    // MARK: - VC Properties

    var editorheight: CGFloat = 0.0
    var editorBottom: CGFloat = 0.0 {
        didSet {
            editorBottomConstraint.constant = editorBottom
        }
    }

    // MARK: - Actions
    
    @IBAction func onSendButtonTap(_ sender: UIButton) {
        guard let text = messageEditorTextField.text else { return }

        if webSocketController.sendText(text: text) == true {
            viewModel.addSentText(text: text)
            messageEditorTextField.text?.removeAll()
            messageTextFieldChanged()
            chatViewController?.reloadData()
        }
    }

    @IBAction func onVideoButtonTap(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }

        videoPicker.delegate = self
        videoPicker.sourceType = .photoLibrary
        videoPicker.mediaTypes = [kUTTypeMovie as String]
        videoPicker.modalPresentationStyle = .popover
        present(videoPicker, animated: true, completion: nil)
    }

    @IBAction func UIBarButtonItem(_ sender: UIBarButtonItem) {
        guard !chatViewModel.isChatEmpty else { return }
        
        showAlert(withTitle: viewModel.warningMessage,
                  message: viewModel.deleteAllMessage,
                  confirmButtonTitle: viewModel.okButtonTitle,
                  cancelButtonTitle: viewModel.cancelButtonTitle,
                  confirmAction: { action in
                    self.viewModel.removeAll()
                    self.chatViewController?.reloadData()
        })
    }

    // MARK: - VC Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        editorheight = editorBottomConstraint.constant
        webSocketController.delegate = self
        messageTextFieldChanged()

        title = viewModel.title
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let containerScene = segue.destination as? ChatViewController,
            segue.identifier == chatViewControllerName else { return }
        chatViewController = containerScene
    }

    // MARK: - Keyboard support

    @objc func keyboardWillChange(notification: NSNotification) {

        let keyboardResult = viewModel.isKeyboardShown(notification: notification, view: view)
        if keyboardResult.isShown {
            editorBottom = editorheight
            UIView.animate(withDuration: keyboardResult.animateDuration, animations: {
                self.view.layoutIfNeeded()
                self.chatViewController?.scrollTable(animated: false)
            })
        } else {
            editorBottom = keyboardResult.hight + editorheight
            UIView.animate(withDuration: keyboardResult.animateDuration, animations: {
                self.view.layoutIfNeeded()
                self.chatViewController?.scrollTable(animated: false)
            })
        }
    }

    @IBAction func messageTextFieldChanged() {
        guard let text = messageEditorTextField.text else { return }
        sendButton.isEnabled = !text.isEmpty
    }

}

// MARK: - UITextFieldDelegate

extension ConversationViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - WebSocketControllerDelegate

extension ConversationViewController: WebSocketControllerDelegate {

    func didOpen() { }

    func didClose() { }

    func didReceiveError(error: Error) { }

    func didReceiveString(text: String) {
        viewModel.addReceivedText(text: text)
        chatViewController?.reloadData()
    }

    func didReceiveData(data: Data) {
        guard let url = viewModel.saveMovie(data: data) else { return }
        viewModel.addReceivedVideo(url: url)
        chatViewController?.reloadData()
    }

}

// MARK: - UIImagePickerControllerDelegate

extension ConversationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        guard let url = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaURL)] as? URL else { return }
        if webSocketController.sendData(url: url) == true {
            viewModel.addSentVideo(url: url)
            chatViewController?.reloadData()
        }
        self.dismiss(animated: true, completion: nil)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
