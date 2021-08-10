//
//  EarningsDashboardView.swift
//  Yearnings
//
//

import SwiftUI

struct EarningsDashboardView: View {

    @StateObject var allEarningsViewModel = AllEarningsViewModel(stores: AllStores.shared)
    @EnvironmentObject var displayUnitContainer: DisplayUnitContainer
    @EnvironmentObject var userAddressStore: UserAddressStore
    @State private var showingFeedbackSheet = false

    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top) {
                    TotalEarningsView(viewModel: allEarningsViewModel).padding(.vertical, 30)
                    VStack(alignment: .trailing, spacing: 25) {
                        Button(action: {
                            userAddressStore.addresses = []
                        }, label: {
                            HStack(alignment: VerticalAlignment.firstTextBaseline) {
                                Image(systemName: "trash")
                                Text("Clear account\(userAddressStore.addresses.count == 1 ? "" : "s")")
                            }
                        })
                        Button(action: {
                            showingFeedbackSheet = true
                        }, label: {
                            HStack(alignment: VerticalAlignment.firstTextBaseline) {
                                Image(systemName: "ladybug")
                                Text("Feedback")
                            }
                        })
                        Button(action: {
                            allEarningsViewModel.reload.send(userAddressStore.addresses)
                        }, label: {
                            HStack(alignment: VerticalAlignment.firstTextBaseline) {
                                Image(systemName: "arrow.clockwise")
                                Text("Refresh")
                            }
                        })
                    }
                    .padding(.top, 30)
                    .padding(.trailing, 20)
                }

                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Total Apy")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(allEarningsViewModel.aggregatedApyStr)
                            .font(.title)
                    }

                    VStack(alignment: .leading) {
                        Text("Projected Daily Earnings")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(allEarningsViewModel.estimatedEarningsPerDay)
                            .font(.title)
                    }
                    
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 8)

                TitlesView()
                ForEach(allEarningsViewModel.viewModels) { viewModel in
                    VaultView(viewModel: viewModel)
                }
                Text("Assets missing?\nOnly V2 vaults are supported at the moment")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                    .multilineTextAlignment(.center)
            }
        }
        .onAppear {
            allEarningsViewModel.reload.send(userAddressStore.addresses)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            allEarningsViewModel.reload.send(userAddressStore.addresses)
        }
        .alert(item: $allEarningsViewModel.appError) { appError in
            Alert(title: Text("Error 🥴"), message: Text(appError.error.localizedDescription))
        }
        .actionSheet(isPresented: $showingFeedbackSheet) {
            ActionSheet(
                title: Text("Feedback"),
                message: nil,
                buttons: [
                    .default(Text("Open an issue on Github")) {
                        UIApplication.shared.open(Externals.githubIssuesURL)
                    },
                    .default(Text("Tweet the developer")) {
                        UIApplication.shared.open(Externals.twitterURL)
                    },
                    .cancel()
                ]
            )
        }
    }
}
