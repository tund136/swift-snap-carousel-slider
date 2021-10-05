//
//  Home.swift
//  SnapCarouselSlider
//
//  Created by Danh Tu on 05/10/2021.
//

import SwiftUI

struct Home: View {
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
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

