import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Button(action: {
                    selectedTab = 0
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.clear)
                            .contentShape(Rectangle())
                        Label(
                            title: { Text("Passwords") },
                            icon: { Image(systemName: "lock") }
                        )
                        .font(.subheadline)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(selectedTab == 0 ? Color.gray.opacity(0.2) : Color.clear)
                        .border(Color.gray.opacity(0.4))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 100)

                Button(action: {
                    selectedTab = 1
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.clear)
                            .contentShape(Rectangle())
                        Label(
                            title: { Text("Utils") },
                            icon: { Image(systemName: "gear") }
                        )
                        .font(.subheadline)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(selectedTab == 1 ? Color.gray.opacity(0.2) : Color.clear)
                        .border(Color.gray.opacity(0.4))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 100)
            }
            .padding(.top)

            if selectedTab == 0 {
                PasswordListView()
            } else {
                UtilsView()
            }
            Spacer()
        }
    }
}
