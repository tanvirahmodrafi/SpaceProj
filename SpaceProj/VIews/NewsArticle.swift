//
//  NewsArticle.swift
//  SpaceProj
//
//  Created by Tanvir on 10/11/2023.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct NewsArticle: View{
    
    
    let title: String
    let imageUrl: String
    let siteName: String
    let summary: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(siteName)
                .foregroundColor(.blue)
                .italic()
        }
        HStack(alignment: .center){
            CachedAsyncImage(url: URL(string: imageUrl),
                             transaction: Transaction(animation: 
                                    .easeInOut)) {
                phase in
                if let image = phase.image{
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }else{
                    HStack {
                        ProgressView()
                    }
                }
            }
        }
        Text(title)
            .font(.headline)
            .padding(8)
            
        Text(summary)
            .lineLimit(6)
            .font(.body)
            .padding(8)
        }
}
struct NewsArticle_Previews: PreviewProvider{
    static var previews: some View {
        NewsArticle(title: "Code palace", imageUrl: "...", siteName: "codePalace", summary: "Cheak code palace for more tutorials")
    }
}
