//
//  StorageManager.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    let storage = Storage.storage().reference()
    

    public func uploadItem(data: Data?, id: String, completion: @escaping (URL?) -> Void) {
        guard let data = data else {return}
        
        let ref = storage.child("items/\(id).png")
        ref.putData(data, metadata: nil) {
            _, error in
            ref.downloadURL { url, _ in
                completion(url)
            }
        }

    }
}
