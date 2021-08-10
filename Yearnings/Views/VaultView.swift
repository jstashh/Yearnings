//
//  VaultView.swift
//  Yearnings
//

//

import SwiftUI
import Combine
import BigInt
import SwiftUICharts

struct VaultView: View {

    private let iconSize: CGFloat = 40.0

    @Environment(\.colorScheme) private var colorScheme
    @StateObject var viewModel: VaultEarningsViewModel
    @EnvironmentObject var displayUnitContainer: DisplayUnitContainer
    @State private var showChart = false

    var body: some View {
        VStack {
            HStack {
                HStack(alignment: .center) {
                    Image(uiImage: viewModel.tokenIcon)
                        .resizable()
                        .frame(width: iconSize, height: iconSize)

                    Text(viewModel.vaultName)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .fixedSize(horizontal: true, vertical: false)

                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(displayUnitContainer.displayUnit == .native ? viewModel.depositedNativeText : viewModel.depositedUsdcText)
                            .font(.title2)
                        Text(displayUnitContainer.displayUnit == .native ? viewModel.depositedUsdcText : viewModel.depositedNativeText)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(displayUnitContainer.displayUnit == .native ? viewModel.earningsNativeText : viewModel.earningsInUsdcText)
                                .font(.title2)
                            Text(displayUnitContainer.displayUnit == .native ? viewModel.earningsInUsdcText : viewModel.earningsNativeText)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .lineLimit(1)
                        .truncationMode(.tail)
                    }
                    .frame(width: 120)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 10))
            .contentShape(Rectangle())
            .onTapGesture {
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
                viewModel.fetchHistoricalEarningsData()
                withAnimation(.easeIn(duration: 0.2)) {
                    self.showChart.toggle()
                }
            }

            if showChart {
                if viewModel.isLoadingHistoricalEarningsData {
                    ProgressView()
                        .padding(.vertical, 80)
                } else {
                    CardView {
                        ChartLabel(viewModel.vaultName, type: .title, format: "%.04f")
                        HStack {
                            Text("one month")
                                .font(.caption)
                                .padding(.bottom)
                                .padding(.leading, 8)
                            Spacer()
                        }
                        LineChart()
                    }
                    .data(viewModel.historicalEarningsData)
                    .chartStyle(
                        colorScheme == .dark
                            ? ChartStyle(backgroundColor: .black, foregroundColor: [.orangeBright])
                            : ChartStyle(backgroundColor: .white, foregroundColor: [.orangeBright])
                    )
                    .frame(height: 200)
                    .padding([.horizontal, .bottom])
                }
            }
        }
    }
}
