//
//  sectionJSONTests.swift
//  sectionJSONTests
//
//  Created by Michael Zhou on 7/28/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import XCTest
@testable import sectionJSON

class sectionJSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadJSONFile() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let path = NSBundle.mainBundle().pathForResource("S65g-1", ofType: "json")
        XCTAssertNotNil(path)
        let data = NSData(contentsOfFile: path!)
        XCTAssertNotNil(data)
    }
    
    func testDeserializeJSON(){
        let deserializedPath = deserializedFile()
        XCTAssertTrue(deserializedPath is [AnyObject])
    }
    
    func deserializedFile() -> [AnyObject]{
         let path = NSBundle.mainBundle().pathForResource("S65g-1", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let deserializedPath = try? NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
        return deserializedPath as! [AnyObject]
    }
    
    func testArrayContainsDictionaries(){
        let deserializedPath = deserializedFile()
        XCTAssertTrue(deserializedPath is [NSDictionary])
    }
    
    func testDictionaryKeys(){
        let deserializedPath = deserializedFile()
        for obj in deserializedPath{
            XCTAssertNotNil(obj["title"])
            XCTAssertNotNil(obj["contents"])
        }
    }
    
    func parseJSON() -> [GridConfiguration]{
        let deserializedPath = deserializedFile()
        let parser = GridConfigurationParser(configurations: deserializedPath)
        let configs = parser.parse()
        return configs!
    }
    
    
    func testParser(){
       let configs =  parseJSON()
        XCTAssertNotNil(configs)
        XCTAssertEqual(configs.count, 2)
    
    }
    
    func testParserObjectContent(){
        let configs = parseJSON()
        XCTAssertEqual(configs[0].title, "Blinker")
        XCTAssertEqual(configs[1].title, "Pentadecthlon")
    }
    
}
