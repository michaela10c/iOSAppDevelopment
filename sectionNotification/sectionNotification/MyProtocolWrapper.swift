//
//  MyProtocolWrapper.swift
//  sectionNotification
//
//  Created by Michael Zhou on 7/21/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation

class MyProtocolWrapper{
    
    let myVariable : MyProtocol
    
    required init(variable: MyProtocol){
            myVariable = variable
    }
}