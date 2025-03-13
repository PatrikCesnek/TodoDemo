//
//  ErrorView.swift
//  iosApp
//
//  Created by Patrik Cesnek on 13/03/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    private let error: String
    private let tryAgain: () -> Void
    
    init(
        error: String,
        tryAgain: @escaping () -> Void
    ) {
        self.error = error
        self.tryAgain = tryAgain
    }
    
    var body: some View {
        VStack(spacing: 20){
            Image(systemName: Constants.Images.errorImage)
                .resizable()
                .frame(width: 100, height: 100)
            
            Text(error)
                .font(.title)
                .multilineTextAlignment(.center)
            
            Button(
                action: {
                    tryAgain()
                },
                label: {
                    Text(Constants.Strings.tryAgain)
                }
            )
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ErrorView(
        error: "OOOPs something went wrong",
        tryAgain: {}
    )
}
