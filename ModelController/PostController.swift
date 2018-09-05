//
//  PostController.swift
//  SubredditCodable
//
//  Created by Levi Linchenko on 04/09/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class PostController{
    
    static let shared = PostController()
    private init() {}
    
    
    let baseURL = URL(string: "https://www.reddit.com/r")

    
    func fetchPosts(by PostName: String, completion: @escaping ([Post]?) -> Void){
        
        let thisURL = self.baseURL?.appendingPathComponent(PostName).appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: thisURL!) { (data, _, error) in
            
        
            defer { completion(nil)}
            do{
                
                if let error = error {throw error}
                guard let data = data else {throw NSError()}
                
                let jsonDictionary = try JSONDecoder().decode(JSONDictionary.self, from: data)
                let posts = jsonDictionary.data.children.flatMap( { $0.post})
                //????
                completion(posts)
                
                
            } catch let error {
                print("💩 Error fetching data, \(error).. \(error.localizedDescription)")
                return
                
            }
        }.resume()
        
    }
    
    func fetchImage(postThumbNail: String, completion: @escaping (UIImage?) -> Void){
        
        guard let imageURL = URL(string: postThumbNail) else {return}
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            
            defer{completion(nil)}
            guard let data = data else {print("💩 Bad Data"); return} // ????
            do{
                if let error = error {throw error}
                
                let image = UIImage(data: data)
                completion(image)
            } catch let error {
                print("error fetching image\(error)\(error.localizedDescription)")
                return
            }
        }.resume()
    }
    
    
    
}
