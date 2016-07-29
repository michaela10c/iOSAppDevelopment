//
//  GridConfigurationParser.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/29/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation

//sample code from Nathan Guerin's section

struct GridConfiguration{
    var title : String
    var points : [(Int,Int)]
}

class GridConfigurationParser{
    let configs: [AnyObject]
    
    init(configurations: [AnyObject]){
        configs = configurations
    }
    
    func parse() -> [GridConfiguration]?{
        let dictionaryConfigs = configs as! [NSDictionary]
        var parsedConfigs : [GridConfiguration] = []
        
        parsedConfigs = dictionaryConfigs.map({(dict) -> GridConfiguration in
            let title = dict["title"] as! String
            let content = dict["contents"] as! [[Int]]
            let tupleContent = content.map({($0[0], $0[1])})
            return GridConfiguration(title: title, points: tupleContent)
        });
        return parsedConfigs
    }
}