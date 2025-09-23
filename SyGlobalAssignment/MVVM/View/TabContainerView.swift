import SwiftUI

import SwiftUI

struct TabContainerView: View {
    @State private var selectedIndex: Int = 0
    @State private var previousIndex: Int = 0
    
    let tabs: [(icon: String, title: String)] = [
        ("magnifyingglass", "Explore"),
        ("heart", "Wishlists"),
        ("airplane", "Trips"),
        ("message", "Messages"),
        ("person.circle", "Profile")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                switch selectedIndex {
                case 0: ExploreView()
                case 1: WishlistView()
                case 2: HomeView()
                case 3: MessagesView()
                case 4: ProfileView()
                default: ExploreView()
                }
            }
            .id(selectedIndex)
            .transition(
                selectedIndex > previousIndex
                ? .move(edge: .trailing).combined(with: .opacity)
                : .move(edge: .leading).combined(with: .opacity)
            )
            .animation(.easeInOut(duration: 0.35), value: selectedIndex)
            
            HStack {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Spacer()
                    
                    Button {
                        previousIndex = selectedIndex
                        selectedIndex = index
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: tabs[index].icon)
                                .font(.system(size: 22))
                                .foregroundColor(selectedIndex == index ? .red : .gray)
                            
                            Text(tabs[index].title)
                                .font(.system(size: 12))
                                .foregroundColor(selectedIndex == index ? .red : .gray)
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding(.vertical, 15)
            .background(Color.white.shadow(radius: 2))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}



struct ExploreView: View {
    var body: some View {
        VStack {
            CustomHeaderView(title: "Explore")
            
            Color.yellow.opacity(0.3)
                .overlay(Text("Explore View").font(.largeTitle))
        }
    }
}

struct WishlistView: View {
    var body: some View {
        
        VStack {
            CustomHeaderView(title: "Wishlist")
            
            Color.green.opacity(0.3)
                .overlay(Text("Wishlist View").font(.largeTitle))
            
        }
    }
}

struct TripsView: View {
    var body: some View {
        VStack {
            CustomHeaderView(title: "Trips")
            Color.blue.opacity(0.3)
                .overlay(Text("Trips View").font(.largeTitle))
        }
    }
}

struct MessagesView: View {
    var body: some View {
        
        VStack {
            CustomHeaderView(title: "Messages")
            
            List {
                ForEach(0..<5) { _ in
                    self.msgCell()
                }
            }
        }
    }
    @ViewBuilder func msgCell() -> some View {
        
        HStack {
            
            Image("iPhone")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("John Doe")
                    .font(.headline)
                
                Text("Hi, I'm John Doe. Lorem ipsum dolor sit amet.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("Monday")
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
}

struct ProfileView: View {
    var body: some View {
        
        VStack {
            CustomHeaderView(title: "Profile")
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    VStack(spacing: 8) {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 80, height: 80)
                            .overlay(
                                Text("S")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            )
                        
                        Text("SY Group")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Guest")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    HStack(spacing: 16) {
                        featureCard(
                            imageName: "suitcase.fill",
                            title: "Past trips",
                            badgeText: "NEW"
                        )
                        
                        featureCard(
                            imageName: "person.3.fill",
                            title: "Connections",
                            badgeText: "NEW"
                        )
                    }
                    .padding(.horizontal)
                    
                    featureCard(
                        imageName: "house.fill",
                        title: "Become a host",
                        subtitle: "It’s easy to start hosting and earn extra income",
                        isFullWidth: true
                    )
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        
    }
    @ViewBuilder
    private func featureCard(imageName: String, title: String, subtitle: String? = nil, badgeText: String? = nil, isFullWidth: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                Spacer()
                
                if let badge = badgeText {
                    Text(badge)
                        .font(.caption2)
                        .bold()
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            
            Text(title)
                .font(.headline)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: isFullWidth ? .infinity : nil)
        .frame(height: isFullWidth ? 100 : 120)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 2)
    }
}

