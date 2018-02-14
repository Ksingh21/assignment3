//
//  Datamodel.swift
//  assignment3
//
//  Created by Khushwant Singh on 2018-02-13.
//  Copyright © 2018 Khushwant Singh. All rights reserved.
//

import UIKit

class Datamodel: NSObject {
   var attraction: [AttractionItem] = [AttractionItem]()
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
        in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath() -> URL {
        print(documentDirectory())
        return documentDirectory().appendingPathComponent("Attraction.plist")
    }
    func saveAttraction() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(attraction)
            try data.write(to: dataFilePath())
        } catch {
            print("Encoding Error Occured")
        }
    }
    func loadAttraction() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            do {
                let decoder = PropertyListDecoder()
                attraction = try decoder.decode([AttractionItem].self, from: data)
            } catch {
                print("Decoding Error Occured")
            }
        }
    }
}
