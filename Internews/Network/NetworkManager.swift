//
//  NetworkManager.swift
//  Internews
//
//  Created by Evgeny Yagrushkin on 2020-12-01.
//

import Foundation

protocol NetworkManagerProtocol {
    func getAlbums(completion: @escaping ([Album], _ error: Error?)->Void)
    func getPhotos(with albumId: Int, completion: @escaping ([Photo], _ error: Error?)->Void)
}

enum NetworkError: Error {
    case serverError
    case dataMissing
}

class NetworkManager: NetworkManagerProtocol {

    struct urls {
        static let albumsURL = "https://jsonplaceholder.typicode.com/albums"
        static let photosURL = "https://jsonplaceholder.typicode.com/photos"
    }
    
    let session = URLSession.shared
    
    func getAlbums(completion: @escaping ([Album], _ error: Error?)->Void) {
        
        let url = URL(string: urls.albumsURL)!
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion([], NetworkError.serverError)
                return
            }
            
            guard let data = data else {
                completion([], NetworkError.dataMissing)
                return
            }
            
            do{
                let albums = try JSONDecoder().decode([Album].self, from: data)
                completion(albums, nil)
            } catch{
                completion([], NetworkError.dataMissing)
                return
            }
        }
        task.resume()
    }
    
    func getPhotos(with albumId: Int, completion: @escaping ([Photo], _ error: Error?)-> Void) {

        let url = URL(string: "\(urls.photosURL)?albumId=\(albumId)")!
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion([], NetworkError.serverError)
                return
            }
            
            guard let data = data else {
                completion([], NetworkError.dataMissing)
                return
            }
            
            do{
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(photos, nil)
            } catch{
                completion([], NetworkError.dataMissing)
                return
            }
        }
        task.resume()
    }
    
}
