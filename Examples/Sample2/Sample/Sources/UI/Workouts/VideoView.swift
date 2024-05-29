// 
//  VideoView.swift
//  InWorkoutTools

//  Created by Filip Božić on 13. 5. 24
//  Copyright © 2024, Inova IT – All Rights Reserved.
// 
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
// 
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.
import CommonModels
import SwiftUI
import AVKit

public struct VideoView: View {
    private let screenWidth = UIScreen.main.bounds.width
    let currentMedia: Media?
    let player: AVPlayer?
    
    public var body: some View {
        Color.white
            .aspectRatio(16 / 9, contentMode: .fit)
            .frame(minWidth: 0, maxWidth: .infinity) 
            .overlay(
                VStack {
                    if let currentMedia, let url = currentMedia.url, currentMedia.mimeType.isImage {
                        if currentMedia.mimeType == .gif {
                            EmptyView()
//                            GifView(url: url)
//                                .frame(width: screenWidth, height: screenWidth * 9 / 16)
//                                .background(.black)
//                                .padding(.top, Constants().safeAreaTop)
                        } else {
                            AsyncImage(url: url) { image in
                                if let image = image.image {
                                    image
                                        .resizable()
                                        .frame(width: screenWidth, height: screenWidth * 9 / 16)
                                        .aspectRatio(contentMode: .fill)
                                        .padding(.top, Constants().safeAreaTop)
                                }
                            }
                        }
                    } else if let currentMedia, currentMedia.mimeType.isVideo {
                        if let player {
                            VideoPlayer(player: player)
                                .disabled(true)
                                .frame(width: screenWidth, height: screenWidth * 9 / 16)
                                .background(.black)
                                .padding(.top, Constants().safeAreaTop)
                        }
                    }
                }
            )
    }
}
