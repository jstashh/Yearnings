//
//  TotalEarningsView.swift
//  Yearnings
//

//

import SwiftUI

struct TotalEarningsView: View {

    @StateObject var viewModel: AllEarningsViewModel
    @EnvironmentObject var displayUnitContainer: DisplayUnitContainer

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Total Earned")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(displayUnitContainer.displayUnit == .native ? viewModel.totalEarningsEth : viewModel.totalEarningsUsdc)
                    .font(.title)
                Text(displayUnitContainer.displayUnit == .native ? viewModel.totalEarningsUsdc : viewModel.totalEarningsEth)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)

                Text("Net Worth")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(displayUnitContainer.displayUnit == .native ? viewModel.netWorthEth : viewModel.netWorthUsdc)
                    .font(.title)
                Text(displayUnitContainer.displayUnit == .native ? viewModel.netWorthUsdc : viewModel.netWorthEth)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.leading, 20)
        .contentShape(Rectangle())
        .onTapGesture(perform: {
            displayUnitContainer.displayUnit.toggle()
        })
    }
}

