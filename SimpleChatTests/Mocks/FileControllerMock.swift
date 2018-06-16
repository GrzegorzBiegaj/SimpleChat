//
//  FileControllerMock.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation
@testable import SimpleChat

class FileControllerMock: FileControllerProtocol {

    func saveMovie(data: Data) -> URL? {
        return nil
    }

}
