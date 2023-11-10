//
//  APIClient.swift
//  SpaceProj
//
//  Created by Tanvir on 09/11/2023.
//
//API End Point: https://api.spaceflightnewsapi.net/v4/articles/

import Foundation

struct SpaceData : Codable,Identifiable {
    var id: Int
    var title: String
    var url: String
    var image_url: String
    var news_site: String
    var summary: String
    var published_at: String
    
}

@MainActor class SpaceAPI : ObservableObject {
    @Published var news: [SpaceData] = []
    
    func getData(){
        guard let url = URL(string:"https://api.spaceflightnewsapi.net/v4/articles?_limit=10") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else{
                let tempError = error!.localizedDescription
                DispatchQueue.main.async {
                    self.news = [SpaceData(id: 0, title: tempError, url: "Error", image_url: "Error", news_site: "Title Error", summary: "Try swiping dawn to refresh as soon as you have internet", published_at: "Error")]
                }
                return
            }
            let jsonData = try! JSONSerialization.data(withJSONObject: data)

            // Convert to a string and print
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
               print(JSONString)
            }
            let spaceData = try! JSONDecoder().decode([SpaceData].self, from: data)
            
            DispatchQueue.main.async {
                print("Loaded new data successfully. Articles: \(spaceData.count)")
                self.news = spaceData
            }
        }.resume()
    }
}
