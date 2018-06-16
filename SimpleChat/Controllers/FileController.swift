//
//  FileController.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 15.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol FileControllerProtocol {

    func saveMovie(data: Data) -> URL?
}

class FileController: FileControllerProtocol {

    // MARK: - Public interface
    
    func saveMovie(data: Data) -> URL? {
        var url: URL?
        let fileName = UUID().uuidString
        let dir = try? FileManager.default.url(for: .moviesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        if let fileURL = dir?.appendingPathComponent(fileName).appendingPathExtension("m4v") {
            url = fileURL
            do {
                try data.write(to: fileURL)
            } catch {
                return nil
            }
        }
        return url
    }
}
