---
layout: post
title: 🐦 Swift - Mocking
date: '2015-09-17T15:30:00.001-07:00'
author: Scott McCoy
tags: 
modified_time: '2015-10-08T15:26:07.117-07:00'
blogger_id: tag:blogger.com,1999:blog-250956833460526415.post-8458479091898452779
blogger_orig_url: https://scotthmccoy.blogspot.com/2015/09/mocking-in-swift.html
---

```
func testDatabaseHasRecordsForSomeEntityReturnsFalseWhenFetchRequestReturnsEMPTYArray() {
    class MockNSManagedObjectContext: NSManagedObjectContext {
        override func executeFetchRequest(request: NSFetchRequest, error: NSErrorPointer) -> [AnyObject]? {
            return [] // Provided a different stub implementation to test the "false" branch of my method under test
        }
    }
    
    // Instantiate mock
    let mockContext = MockNSManagedObjectContext()
    
    // Instantiate class under test
    let myClassInstance = MyClass(managedObjectContext: mockContext)
    
    // Call the method under test and store its return value for XCTAssert
    let returnValue = myClassInstance.databaseHasRecordsForSomeEntity()
    
    XCTAssertTrue(returnValue == false, "The return value should be been false")
}
```
