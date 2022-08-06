//
//  NetworkingManager.swift
//  StubhubTask
//
//  Created by Hesham Donia on 06/08/2022.
//

import Foundation

class JsonFileManager {
    
    static let instance = JsonFileManager()
    
    func requestJsonData(fileName: String, successHandler: @escaping (_ response: Data?) -> (), errorHandler: @escaping (_ error: String?) -> ()) {
        if let path = Bundle.main.path(forResource: "\(fileName)", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  successHandler(data)
              } catch let error {
                  errorHandler(error.localizedDescription)
              }
        } else {
            errorHandler("File \(fileName).json not found")
        }
    }
}
