//
//  DatabaseManager.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    public var isPaginating = false
    
    enum DatabaseError {
        case failedToFetch
    }
    
    // MARK: this creates a user when signing up
    
    public func createUser(newuser: User, completion: @escaping (Bool) -> Void) {
        let reference = database.document("users/\(newuser.email)")
        guard let data = newuser.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) {
            error in
            completion(error == nil)
        }
        
    }
    
    
    
    // MARK: find user with email
    
    public func findUser(with email: String, completion: @escaping (User?) -> Void) {
        let ref = database.collection("users")
        ref.whereField("email", isEqualTo: email).getDocuments(completion: { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }), error == nil else {
                completion(nil)
                return
            }
            let user = users.first(where: { $0.email == email })
            completion(user)
        })
    }
    
    //MARK: get and set user info
    
    public func getUserInfo(email: String, completion: @escaping (UserInfo?) -> Void) {
        let ref = database.collection("users").document(email).collection("information").document("basic")
        ref.getDocument { snapshot, error in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let data = snapshot?.data(), let userInfo = UserInfo(with: data) else {
                completion(nil)
                return
            }
            completion(userInfo)
        }
    }
    
    public func setUserInfo(userInfo: UserInfo, completion: @escaping (Bool) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: "email") else {return}
        guard let data = userInfo.asDictionary() else {return}
        
        
        let ref = database.collection("users").document(email).collection("information").document("basic")
        ref.setData(data) { error in
            completion(error == nil)
        }
    }
    
    public func setUserInfoWithEmail(userInfo: UserInfo, email: String, completion: @escaping (Bool) -> Void) {
        guard let data = userInfo.asDictionary() else {return}
        let ref = database.collection("users").document(email).collection("information").document("basic")
        ref.setData(data) { error in
            completion(error == nil)
        }
    }
    
    //MARK: report an issue
    
    public func reportIssue(issue: Issue, id: String, completion: @escaping (Bool) -> Void) {
        let ref = database.collection("issues")
            .document(id)
        guard let issueData = issue.asDictionary() else {
            completion(false)
            return
            
        }
        ref.setData(issueData, completion: {
            error in
            completion(error == nil)
        })
    }
    
    //MARK: create an item listing
    
    public func createItem(newItem: Item, completion: @escaping (Bool) -> Void) {
        let reference = database.collection("items").document(newItem.productId)
        guard let data = newItem.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) {
            error in
            completion(error == nil)
        }
    }
    
    //MARK: grabbing items
    
    public func grabItems(completion: @escaping ([Item], DocumentSnapshot?) -> Void) {
        self.isPaginating = true
        let ref = database.collection("items").order(by: "postedDateNum", descending: true).limit(to: 100)
        ref.getDocuments(completion: {
            [weak self] snapshot, error in
            if error == nil {
                guard let items = snapshot?.documents.compactMap({ Item(with: $0.data() )}) else {
                    completion([], nil)
                    self?.isPaginating = false
                    return
                }
                guard let lastSnapshot = snapshot?.documents.last else {
                    completion([], nil)
                    self?.isPaginating = false
                    return
                }
                completion(items, lastSnapshot)
                self?.isPaginating = false
            } else {
                print("error in getting posts")
                completion([], nil)
                self?.isPaginating = false
            }
        })
    }
        
    
    public func continueAllPosts(lastDoc: DocumentSnapshot, completion: @escaping ([Item], DocumentSnapshot?) -> Void) {
       
        self.isPaginating = true
        let ref = database.collection("Items").order(by: "postedDateNum", descending: true).start(afterDocument: lastDoc).limit(to: 20)
        ref.getDocuments(completion: {
            snapshot, error in
            if error == nil {
                guard let items = snapshot?.documents.compactMap({ Item(with: $0.data() )}) else {
                    completion([], nil)
                    self.isPaginating = false
                    return
                }
                guard let lastSnapshot = snapshot?.documents.last else {
                    completion([], nil)
                    self.isPaginating = false
                    return
                }
                completion(items, lastSnapshot)
                self.isPaginating = false
            } else {
                print("error in getting posts")
                completion([], nil)
                self.isPaginating = false
            }
        })
    }
    
    public func getItem(item: String, completion: @escaping (Item?) -> Void) {
        let ref = database.collection("items").whereField("productId", isEqualTo: item)
        ref.getDocuments(completion: {
            [weak self] snapshot, error in
            guard error == nil else  {
                completion(nil)
                return
            }
            guard let items = snapshot?.documents.compactMap({ Item(with: $0.data() )}) else {
                completion(nil)
                return
            }
            if !items.isEmpty {
                completion(items[0])
            } else {
                print("empty")
                completion(nil)
            }
            
        })
    }
    
    
    public func updateItemSold(item: String, completion: @escaping(Bool) -> Void) {
        let ref = database.collection("items").document(item)
        ref.updateData(["isSold": true]) {
            error in
            completion(error == nil)
        }
    }
    
    public func updateMultipleItemsSold(items: [Item]) {
        for item in items {
            updateItemSold(item: item.productId, completion: {
                success in
                if success {
                    print("sold updated")
                } else {
                    print("not able to update sold status")
                }
            })
        }
    }
    
    

    //MARK: get user current cart
    
    public func getUserCart(with email: String, completion: @escaping ([String]) -> Void) {
        let ref = database.collection("users").document(email).collection("currentCart")
        ref.getDocuments(completion: {
            snapshot, error in
            if error == nil {
                guard let items = snapshot?.documents.compactMap( { $0.documentID }), error == nil else {
                    completion([])
                    return
                }
                completion(items)
            } else {
                print("error in getting posts")
                completion([])
            }
            
        })
    }
    
    //MARK: add item to cart
    
    
    
    public func addItemToCart(email: String, item: String, completion: @escaping (Bool) -> Void) {
        let ref = database.collection("users").document(email).collection("currentCart")
        ref.document(item).setData(["valid": 1], completion: {
            error in
            completion(error == nil)
        })
    }
    
    //MARK: remove item from cart
    
    public func removeItemFromCart(email: String, item: String, completion: @escaping (Bool) -> Void) {
        let ref = database.collection("users").document(email).collection("currentCart").document(item)
        ref.delete(completion: {
            error in
            completion(error == nil)
        })
        
    }
    
    public func removeItemsFromCartAfterPurchase(email: String, items: [Item], completion: @escaping (Bool) -> Void) {
        for item in items {
            removeItemFromCart(email: email, item: item.productId, completion: {
                success in
                if success {
                    print("success")
                    completion(true)
                } else {
                    print("failure")
                    completion(false)
                }
            })
        }
        
    }
    
    //MARK: purchase
    
    public func updatePurchase(email: String, order: PurchaseOrder, orderNumber: Int, completion: @escaping (Bool) -> Void) {
        let ref = database.collection("orders").document("\(orderNumber)")
        guard let data = order.asDictionary() else {
            completion(false)
            return
        }
        ref.setData(data, completion: {
            error in
            completion(error == nil)
        })
    }
    
    public func updateUserPurchase(email: String, order: PurchaseOrder, orderNumber: Int, completion: @escaping (Bool) -> Void) {
        let ref = database.collection("users").document(email).collection("orders").document("\(orderNumber)")
        guard let data = order.asDictionary() else {
            completion(false)
            return
        }
        ref.setData(data, completion: {
            error in
            completion(error == nil)
        })
    }
    
    public func getPurchasedItemsForUser(email: String, completion: @escaping ([PurchaseOrder], Bool) -> Void) {
        let ref = database.collection("users").document(email).collection("orders")
        ref.getDocuments(completion: {
            snapshot, error in
            guard error == nil else {
                completion([], false)
                print(error)
                return
            }
            guard let items = snapshot?.documents.compactMap({ PurchaseOrder(with: $0.data() )}) else {
                completion([], false)
                return
            }
            completion(items, true)
            
        })
    }
    
    //MARK: verify admin account
    
    public func verifyAccount(password: String, email: String, completion: @escaping (Bool) -> Void) {
        let ref = database.collection("verify").whereField("password", isEqualTo: password).whereField("email", isEqualTo: email.lowercased())
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                completion(false)
                return
            }
            guard let data = snapshot?.documents.compactMap({ $0.data() }) else {
                completion(false)
                return
            }
            if data.isEmpty {
                completion(false)
            } else {
                completion(true)
            }
            
        }
        
    }
}
