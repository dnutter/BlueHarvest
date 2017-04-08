//
//  BlueHarvestTests.swift
//  BlueHarvestTests
//
//  Created by David Nutter on 3/11/17.
//  Copyright © 2017 David Nutter. All rights reserved.
//

import XCTest
@testable import BlueHarvest

class BlueHarvestTests: XCTestCase {
    
    var ex: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFailClient() {
        let ex = expectation(description: "FailClient.retrieve")
        let client = FailClient()
        client.retrieveProfiles() { error, profiles in
            XCTAssert(error != nil, "FailClient.retrieveProfiles should errror")
            ex.fulfill()
        }
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFakeClient() {
        
        let ex = expectation(description: "FakeClient.retrieve")
        let client = FakeClient()
        client.retrieveProfiles() { error, profiles in
            XCTAssert(error == nil, "FakeClient.retrieveProfiles should not errror")
            ex.fulfill()
        }
        
        self.waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func testProfileFormatter() {
        
        let empty = Dictionary<String, Any>()
        XCTAssertNil(ProfileFormatter().makeProfile(from: empty))
        XCTAssertNil(ProfileFormatter().makeProfileList(from: empty))
        
        let malformed = ["indivvvviduals": 31]
        XCTAssertNil(ProfileFormatter().makeProfileList(from: malformed))
        
        let profilePicture = "https://upload.wikimedia.org/wikipedia/en/9/9b/Luke_Skywalker.png"
        
        let validProfile: [String: Any] = [
            "firstName": "Luke",
            "lastName": "Skywalker",
            "birthdate": "1963-05-05",
            "profilePicture": profilePicture,
            "forceSensitive": true,
            "affiliation": "JEDI"
        ]
        
        XCTAssertNil(ProfileFormatter().makeProfileList(from: validProfile), "profileList should be nil")
        
        guard let profile = ProfileFormatter().makeProfile(from: validProfile) else {
            XCTFail("Profile should not be nil")
            return
        }
        
        XCTAssert(profile.firstName == "Luke", "profile first name should be Luke")
        XCTAssert(profile.lastName == "Skywalker", "profile last name should be Skywalker")
        XCTAssert(profile.birthdate == "1963-05-05", "profile birthdate  should be 1963-05-05")
        XCTAssert(profile.profilePicture == profilePicture, "profile picture URL should be \(profilePicture)")
        XCTAssert(profile.forceSensitive == true, "profile should be force sensitive")
        XCTAssert(profile.affiliation == .jedi, "profile affiliation should be .jedi")
        
    }
    
    func testProfileSerializable() {
        let profile = Profile(firstName: "Mara", lastName: "Jade", birthdate: "1964-01-05", profilePicture: "", forceSensitive: true, affiliation: .sith)
        
        let dictionary = profile.asDictionary()
        
        guard let profileFromDict = Profile(with: dictionary) else {
            XCTFail("profileFromDict should not be nil")
            return
        }
        
        XCTAssert(profile.firstName == profileFromDict.firstName, "profile first name should be identical")
    }
    
}

extension BlueHarvestTests: ViewModelDelegate {
    
    func testViewModel() {
        
        self.ex = expectation(description: "ViewModel.update")
        
        let viewModel = ViewModel(FakeClient())
        viewModel.delegate = self
        viewModel.profiles.removeAll()
        
        viewModel.update()
        
        self.waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    
    func viewModelDidUpdate(_ viewModel: ViewModel) {
        XCTAssert(!viewModel.profiles.isEmpty, "viewModel should not be empty")
        self.ex?.fulfill()
    }
}
