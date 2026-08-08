//
//  PillTagView.swift
//  04-Pokemon-Dex-SwiftUI
//
//  Created by sorlenko on 08/08/2026.
//

import SwiftUI

struct PillTagView: View {
    
    let title: String
    
    init(for type: String) {
        self.title = type
    }
    
    var body: some View {
        Text(title.capitalized)
            .font(.system(size: 16, weight: .semibold))
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
            .background(Color(title.capitalized).opacity(0.5))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(title.capitalized), lineWidth: 4)
            }
            .clipShape(.capsule)
    }
}
