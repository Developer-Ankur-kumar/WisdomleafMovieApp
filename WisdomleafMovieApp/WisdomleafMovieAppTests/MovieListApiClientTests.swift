//
//  MovieListApiClientTests.swift
//  WisdomleafMovieAppTests
//
//  Created by Ankur Kumar on 30/08/24.
//

@testable import WisdomleafMovieApp
import XCTest

final class MovieListApiClientTest: XCTestCase {
    private var apiClient: MovieListApiClient?
    
    override func setUp() async throws {
        apiClient = MovieListApiClient()
    }
    
    override func tearDown() async throws {
        
    }
    
    func test_fetchMovieListMethod_withSuccess_shouldReturnMovieLists() {
        // Assert
        let expectation = self.expectation(description: "waiting for api result")
        
        // Act
        apiClient?.fetchMovieList(completionHandler: { result in
            switch result {
            case .success(let movieList):
                // Assert
                XCTAssertFalse(movieList.isEmpty, "Movie list should not be empty")
            case .failure(let failure):
                
                // Assert
                XCTFail("There should not be any error")
            }
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0)
    }
}
