//
//  LazyReleaseableWebImage.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 06/06/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct LazyReleaseableWebImage<T: View>: View {

    @State
    private var shouldShowImage: Bool = false

    private let content: () -> WebImage
    private let placeholder: () -> T

    public init(@ViewBuilder content: @escaping () -> WebImage,
                             @ViewBuilder placeholder: @escaping () -> T) {
        self.content = content
        self.placeholder = placeholder
    }

    public var body: some View {
        ZStack {
            if shouldShowImage {
                content()
            } else {
                placeholder()
            }
        }
        .onAppear {
            shouldShowImage = true
        }
        .onDisappear {
            shouldShowImage = false
        }
    }
}
