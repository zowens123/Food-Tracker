//
//  FoodTrackingTests.swift
//  FoodTrackingTests
//
//  Created by Zach Owens on 1/16/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import XCTest
@testable import FoodTracking

class FoodTrackingTests: XCTestCase {

    //mark: meal class test
    
    //confirm the meal init returns meal obj when passed valid params
    func testMealInitSucceeds(){
        //zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating:0)
            XCTAssertNotNil(zeroRatingMeal)
        
        //highest positive rating
        let postiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
            XCTAssertNotNil(postiveRatingMeal)
    }
    
    //confirm the meal init returns nil when passed a neg rating or empty name
    func testMealInitFails(){
        // negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
            XCTAssertNil(negativeRatingMeal)
        
        //rating exceeds max
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
            XCTAssertNil(largeRatingMeal)
        
        //empty string
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
            XCTAssertNil(emptyStringMeal)
        
        
    }
}
