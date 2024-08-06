import SwiftUI

enum Tab {
    case home
    case createBet
    case profile
}

struct TabContainer: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeScreen()
            }
            .tabItem {
                Image(systemName: "house.fill")
            }
            .tag(Tab.home)

            NavigationView {
                // Content for Scheduler tab
                Text("Scheduler Content")
                    .navigationTitle("Scheduler")
            }
            .tabItem {
                Image(systemName: "plus")
            }
            .tag(Tab.createBet)

            NavigationView {
                Text("Music Content")
                    .navigationTitle("Music")
            }
            .tabItem {
                Image(systemName: "person")
            }
            .tag(Tab.profile)
        }
    }
}

struct TabContainer_Previews: PreviewProvider {
    static var previews: some View {
        TabContainer()
    }
}
