//
//  Home.swift
//  SnapCarouselSlider
//
//  Created by Danh Tu on 05/10/2021.
//

import SwiftUI

struct Home: View {
    @State private var currentIndex: Int = 0
    @State private var posts: [Post] = []
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 12) {
                Button(action: {
                    
                }, label: {
                    Label(title: {
                        Text("Back")
                            .fontWeight(.semibold)
                    }, icon: {
                        Image(systemName: "chevron.left")
                            .font(.title2.bold())
                    })
                        .foregroundColor(.primary)
                })
                
                Text("My Wishes")
                    .font(.title)
                    .fontWeight(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            // Snap Carousel
            SnapCarousel(spacing: 25, index: $currentIndex, items: posts) { post in
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    Image(post.postImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width)
                        .cornerRadius(12)
                }
            }
            .padding(.vertical, 40)
            
            // Indicator
            HStack(spacing: 10) {
                ForEach(posts.indices, id: \.self) { index in
                    Circle()
                        .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                        .frame(width: 10, height: 10)
                        .scaleEffect(currentIndex == index ? 1.4 : 1)
                        .animation(.spring(), value: currentIndex == index)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            for index in 1...5 {
                posts.append(Post(postImage: "post\(index)"))
            }
        }
    }
}

