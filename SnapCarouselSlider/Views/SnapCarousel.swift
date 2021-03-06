//
//  SnapCarousel.swift
//  SnapCarouselSlider
//
//  Created by Danh Tu on 05/10/2021.
//

import SwiftUI

// To for Accepting List
struct SnapCarousel<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    // Properties
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
    }
    
    // Offset
    @GestureState private var offset: CGFloat = 0
    @State private var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            
            // Setting correct Width for Snap Carousel
            // One Sided Scap Carousel
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing: spacing) {
                ForEach(list) { item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                }
            }
            // Spacing will be horizontal padding
            .padding(.horizontal, spacing)
            // Setting only after 0th index
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustMentWidth : 0) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded { value in
                        // Updating current index
                        let offsetX = value.translation.width
                        
                        // Convert the translation into progress (0 - 1) and round the value
                        // Based on the progress increasing or decreasing the currentIndex
                        let progress = -offsetX / width
                        
                        let roundIndex = progress.rounded()
                        
                        // Setting min
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
                        // Updating index
                        currentIndex = index
                    }
                    .onChanged { value in
                        // Updating only index
                        
                        // Updating current index
                        let offsetX = value.translation.width
                        
                        // Convert the translation into progress (0 - 1) and round the value
                        // Based on the progress increasing or decreasing the currentIndex
                        let progress = -offsetX / width
                        
                        let roundIndex = progress.rounded()
                        
                        // Setting min
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    }
            )
        }
        // Animation when offset = 0
        .animation(.easeInOut, value: offset == 0)
    }
}

