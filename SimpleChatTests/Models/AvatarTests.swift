//
//  AvatarTests.swift
//  SimpleChatTests
//
//  Created by Grzegorz Biegaj on 16.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import XCTest
@testable import SimpleChat

class AvatarTests: XCTestCase {

    func testAvatarEquatable() {
        let avatar1 = Avatar(character: "A", backgroundColor: .black, fontColor: .brown)
        let avatar2 = Avatar(character: "A", backgroundColor: .black, fontColor: .brown)
        let avatar3 = Avatar(character: "B", backgroundColor: .red, fontColor: .blue)
        let avatar4 = Avatar(character: "B", backgroundColor: .red, fontColor: .blue)

        XCTAssertEqual(avatar1, avatar2)
        XCTAssertEqual(avatar3, avatar4)
        XCTAssertNotEqual(avatar1, avatar3)
        XCTAssertNotEqual(avatar2, avatar4)
    }
}
