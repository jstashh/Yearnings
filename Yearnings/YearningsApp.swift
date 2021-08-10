//
//  YearningsApp.swift
//  Yearnings
//
//

import SwiftUI

@main
struct YearningsApp: App {

    @StateObject var displayUnit: DisplayUnitContainer = DisplayUnitContainer()
    @StateObject var userAddressStore: UserAddressStore = UserAddressStore()
    private let animationDuration = 0.2

    var body: some Scene {
        WindowGroup {
            if userAddressStore.addresses.isEmpty {
                WelcomeView()
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: animationDuration)))
                    .environmentObject(userAddressStore)
            } else {
                EarningsDashboardView()
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: animationDuration)))
                    .environmentObject(displayUnit)
                    .environmentObject(userAddressStore)
            }
        }
    }
}
