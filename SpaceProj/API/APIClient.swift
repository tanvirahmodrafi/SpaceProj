//
//  APIClient.swift
//  SpaceProj
//
//  Created by Tanvir on 09/11/2023.
//
//API End Point: https://api.spaceflightnewsapi.net/v4/articles/

import Foundation

struct launches : Codable {
    var launchID: String
    var provider: String
    
    enum CodingKeys: String, CodingKey {
            case launchID = "launch_id"
            case provider
        }
    
}
struct provider : Codable {
    var provider: String
}

struct News : Codable, Identifiable {
    var id: Int
    var title: String
    var url: String
    var imageURL: String
    var newsSite: String
    var summary: String
    var publishedAt: String
    var updatedAt: String
    var featured: Bool
    var launches: [launches]
//    var events: [provider]
    
    enum CodingKeys: String, CodingKey {
           case id, title, url
           case imageURL = "image_url"
           case newsSite = "news_site"
           case summary
           case publishedAt = "published_at"
           case updatedAt = "updated_at"
           case featured, launches
       }
}

struct SpaceData : Codable{
    let count: Int
    let next, previous: String
    let results: [News]
}

@MainActor class SpaceAPI : ObservableObject {
    @Published var news: [News] = []
    
    func getData(){
        guard let url = URL(string:"https://api.spaceflightnewsapi.net/v4/articles?_limit=10") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else{
                let tempError = error!.localizedDescription
                DispatchQueue.main.async {
//                    self.news = [SpaceData(id: 0, title: tempError, url: "Error", image_url: "Error", news_site: "Title Error", summary: "Try swiping dawn to refresh as soon as you have internet", published_at: "Error")]
                }
                debugPrint(tempError)
                return
            }
            
            do {
                let spaceData = try JSONDecoder().decode(SpaceData.self, from: data)
                
                DispatchQueue.main.async {
                    print("Loaded new data successfully. Articles: \(spaceData.count)")
                    self.news = spaceData.results
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }.resume()
    }
}
