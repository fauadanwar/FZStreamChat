//
//  SettingsView.swift
//  FZChatStream
//
//  Created by fanwar on 11/11/23.
//

import SwiftUI

struct SettingsView: View {
    private var settingsModel: SettingsModel
    var settingsViewModel: SettingsViewModelProtocol

    init(settingsViewModel: SettingsViewModelProtocol) {
        self.settingsViewModel = settingsViewModel
        self.settingsModel = settingsViewModel.settingsModel
    }
    @State private var isLogoutAlertPresented = false

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: settingsModel.imageName ?? "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)

                Text(settingsModel.name)
                    .font(.title)
                    .padding(.top, 10)

                Spacer()

                Button(action: {
                    isLogoutAlertPresented = true
                }) {
                    Text("Logout")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()

            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .alert(isPresented: $isLogoutAlertPresented) {
                Alert(
                    title: Text("Logout"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .default(Text("Cancel")),
                    secondaryButton: .destructive(Text("Logout")) {
                        settingsViewModel.logout()
                    }
                )
            }
        }
    }
}

#Preview {
    SettingsView(settingsViewModel: SettingsViewModel(settingsModel: SettingsModel(name: "Fouad", imageName: nil), homeViewModel: nil))
}
