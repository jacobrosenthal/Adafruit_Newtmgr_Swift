//
//  MynewtManagerTests.swift
//  MynewtManagerTests
//
//  Created by Jacob Rosenthal on 12/13/17.
//  Copyright © 2017 Adafruit. All rights reserved.
//

import XCTest
@testable import MynewtManager

class MynewtManagerTests: XCTestCase {
    var newtHandler : NewtHandler!

    override func setUp() {
        super.setUp()
        newtHandler = NewtHandler()
        newtHandler.start()
    }

    override func tearDown() {
        newtHandler.stop()
        newtHandler = nil
        super.tearDown()
    }

    func testTaskStats() {

        let responseExpectation = expectation(description: "sendRequest TaskStats")

        let taskStatsResponse = [
            Data(bytes: [0x01, 0x00, 0x01, 0x2c, 0x00, 0x00, 0x00, 0x02, 0xbf, 0x62, 0x72, 0x63, 0x00, 0x65, 0x74, 0x61, 0x73, 0x6b, 0x73, 0xbf, 0x64, 0x69, 0x64, 0x6c, 0x65, 0xbf, 0x64, 0x70, 0x72, 0x69, 0x6f, 0x18, 0xff, 0x63, 0x74, 0x69, 0x64, 0x00, 0x65, 0x73, 0x74, 0x61, 0x74, 0x65, 0x01, 0x66, 0x73, 0x74, 0x6b, 0x75, 0x73, 0x65, 0x18, 0x1e, 0x66, 0x73, 0x74, 0x6b, 0x73, 0x69, 0x7a, 0x18, 0x40, 0x66, 0x63, 0x73, 0x77, 0x63, 0x6e, 0x74, 0x1a, 0x00, 0x01, 0x24, 0x8c, 0x67, 0x72, 0x75, 0x6e, 0x74, 0x69, 0x6d, 0x65, 0x1a, 0x00, 0x01, 0x33, 0x2e, 0x6c, 0x6c, 0x61, 0x73, 0x74, 0x5f, 0x63, 0x68, 0x65, 0x63, 0x6b, 0x69, 0x6e]),
            Data(bytes: [0x00, 0x6c, 0x6e, 0x65, 0x78, 0x74, 0x5f, 0x63, 0x68, 0x65, 0x63, 0x6b, 0x69, 0x6e, 0x00, 0xff, 0x64, 0x6d, 0x61, 0x69, 0x6e, 0xbf, 0x64, 0x70, 0x72, 0x69, 0x6f, 0x18, 0x7f, 0x63, 0x74, 0x69, 0x64, 0x01, 0x65, 0x73, 0x74, 0x61, 0x74, 0x65, 0x01, 0x66, 0x73, 0x74, 0x6b, 0x75, 0x73, 0x65, 0x19, 0x01, 0x52, 0x66, 0x73, 0x74, 0x6b, 0x73, 0x69, 0x7a, 0x19, 0x01, 0xc0, 0x66, 0x63, 0x73, 0x77, 0x63, 0x6e, 0x74, 0x19, 0x4e, 0x26, 0x67, 0x72, 0x75, 0x6e, 0x74, 0x69, 0x6d, 0x65, 0x19, 0x2b, 0x39, 0x6c, 0x6c, 0x61, 0x73, 0x74, 0x5f, 0x63, 0x68, 0x65, 0x63, 0x6b, 0x69, 0x6e, 0x00, 0x6c, 0x6e, 0x65, 0x78, 0x74]),
            Data(bytes: [0x5f, 0x63, 0x68, 0x65, 0x63, 0x6b, 0x69, 0x6e, 0x00, 0xff, 0x66, 0x62, 0x6c, 0x65, 0x5f, 0x6c, 0x6c, 0xbf, 0x64, 0x70, 0x72, 0x69, 0x6f, 0x00, 0x63, 0x74, 0x69, 0x64, 0x02, 0x65, 0x73, 0x74, 0x61, 0x74, 0x65, 0x02, 0x66, 0x73, 0x74, 0x6b, 0x75, 0x73, 0x65, 0x18, 0x4d, 0x66, 0x73, 0x74, 0x6b, 0x73, 0x69, 0x7a, 0x18, 0x50, 0x66, 0x63, 0x73, 0x77, 0x63, 0x6e, 0x74, 0x19, 0xed, 0x48, 0x67, 0x72, 0x75, 0x6e, 0x74, 0x69, 0x6d, 0x65, 0x19, 0x02, 0x52, 0x6c, 0x6c, 0x61, 0x73, 0x74, 0x5f, 0x63, 0x68, 0x65, 0x63, 0x6b, 0x69, 0x6e, 0x00, 0x6c, 0x6e, 0x65, 0x78, 0x74, 0x5f, 0x63, 0x68, 0x65, 0x63, 0x6b, 0x69]),
            Data(bytes: [0x6e, 0x00, 0xff, 0xff, 0xff])]

        let taskStats: [NewtHandler.TaskStats] = [
            NewtHandler.TaskStats(taskId: 1, name: "main", priority: 127, state: 1, runTime: 11065, contextSwichCount: 20006, stackSize: 448, stackUsed: 338, lastSanityCheckin: 0, nextSanityCheckin: 0),
            NewtHandler.TaskStats(taskId: 2, name: "ble_ll", priority: 0, state: 2, runTime: 594, contextSwichCount: 60744, stackSize: 80, stackUsed: 77, lastSanityCheckin: 0, nextSanityCheckin: 0),
            NewtHandler.TaskStats(taskId: 0, name: "idle", priority: 255, state: 1, runTime: 78638, contextSwichCount: 74892, stackSize: 64, stackUsed: 30, lastSanityCheckin: 0, nextSanityCheckin: 0)]

        newtHandler.sendRequest(with: .taskStats, completion: { (data, error) in

            XCTAssertNil(error)
            XCTAssertEqual(data as! [NewtHandler.TaskStats], taskStats)
            responseExpectation.fulfill()
        })
        for data in taskStatsResponse {
            newtHandler.newtReceivedData(data: data, error: nil)
        }

        waitForExpectations(timeout: 10) { error in

        }
    }
    
}