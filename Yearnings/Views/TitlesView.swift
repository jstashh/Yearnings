//
//  HeaderView.swift
//  Yearnings
//

//

import SwiftUI

struct TitlesView: View {
    var body: some View {
        HStack {
            Spacer()

            Text("Deposited")
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(minWidth: 120, alignment: .trailing)

            Text("Earnings")
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(minWidth: 120, alignment: .trailing)
        }
        .padding(.horizontal, 10)
    }
}
