//
//  TestingAsyncUsingExpectationsTests.swift
//  TestingAsyncUsingExpectationsTests
//
//  Created by Mohammad Azam on 4/3/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import XCTest
@testable import TestingAsyncUsingExpectations

class TestingAsyncUsingExpectationsTests: XCTestCase {

    func test_GetAllPosts() {
        
        let expectation = XCTestExpectation(description: "Posts has been downloaded!")
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        var posts = [Post]()
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                XCTFail()
                return
            }
            
            posts =  try! JSONDecoder().decode([Post].self, from: data)
            expectation.fulfill()
            
        }.resume()
        
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(posts.count > 0)
       
    }

}
