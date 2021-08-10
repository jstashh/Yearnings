//
//  WelcomeView.swift
//  Yearnings
//

//

import SwiftUI

struct WelcomeView: View {

    @EnvironmentObject var userAddressStore: UserAddressStore
//    @State private var inputAddress: String = ""
    private var buttonDisabled: Bool {
        inputAddresses.filter { !$0.isEmpty }.isEmpty
    }
    @State private var inputAddresses: [String] = [""]

    var body: some View {
        VStack(alignment: .center) {
            Text("Welcome 👋")
                .font(.title)
                .padding(.bottom, 20)
                .padding(.top, 50)
            Text("Enter your address that you use Yearn with")
            ForEach(inputAddresses.indices, id: \.self) { index in
                HStack {
                    TextField("0x...", text: $inputAddresses[index])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 10)
                    Button("Paste") {
                        if let str = UIPasteboard.general.string {
                            inputAddresses[index] = str
                        }
//                        inputAddresses[index] = UIPasteboard.general.string ?? "'"
                    }
                }
            }
            Button("Add another address") {
                inputAddresses.append("")
            }
            .padding(.bottom)
            Text("Your address is never shared with anyone and is only used for querying data on the blockchain")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            Button(action: {
                self.userAddressStore.addresses = inputAddresses.filter { !$0.isEmpty }.map { Address(string: $0.lowercased()) } 
            }) {
                HStack {
                    Spacer()
                    Text("Next")
                    Spacer()
                }
            }
            .frame(width: 200, height: 44)
            .contentShape(Rectangle())
            .background(buttonDisabled ? Color.gray : Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(8.0)
            .disabled(buttonDisabled)

            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 30)
        .onTapGesture(perform: {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        })
    }
}
