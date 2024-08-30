//
//  DataStorageManagerTests.swift
//  WisdomleafMovieAppTests
//
//  Created by Ankur Kumar on 30/08/24.
//

@testable import WisdomleafMovieApp
import XCTest


final class DataStorageManagerTests: XCTestCase {
    override func setUp() async throws {
        
    }
    
    override func tearDown() async throws {
        
    }
    
    func test_addToListMethod_withTrueValue_shouldReturnTrue() {
        /// Arrange
        let storage = DataStorageManager.shared
        
        /// Act
        storage.addToList("1")
        
        /// Assert
        let isAdded = storage.isAddedToList("1")
        XCTAssertTrue(isAdded, "This should be true")
        
        /// Cleanup
        storage.removeFromList("1")
    }
    
    func test_removeFromListMethod_withSuccessCase_shouldRemoveValueFromStorage() {
        /// Arrange
        let storage = DataStorageManager.shared
        
        /// Act
        storage.addToList("1")
        storage.removeFromList("1")
        
        /// Assert
        let isAdded = storage.isAddedToList("1")
        XCTAssertFalse(isAdded, "This should be false")
        
        /// Cleanup
        storage.removeFromList("1")
    }
}
