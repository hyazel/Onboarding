//
//  Untitled.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//

import SwiftUI

struct BlurView: View {
    var body: some View {
        ZStack {
            ForEach(0..<40) { _ in
                Circle()
                    .fill(Color.pink)
                    .frame(width: 64)
                    .blur(radius: 60)
                    .offset(x: CGFloat(Int.random(in: -100...100)), y: CGFloat(Int.random(in: -100...100)))
            }
            
        }
    }
}

#Preview {
    BlurView().frame(minWidth: 500,
                     minHeight: 300).border(.red)
}

public func makeBlurUIView() -> UIView {
    let blurView = BlurView()
    let hostingController = UIHostingController(rootView: blurView)
    return hostingController.view
}
