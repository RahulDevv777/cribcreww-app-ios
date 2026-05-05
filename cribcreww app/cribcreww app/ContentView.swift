import SwiftUI
import UIKit
import MapKit
import CoreLocation

// ════════════════════════════════════════════════════════════════════
// MARK: - Design System
// ════════════════════════════════════════════════════════════════════

extension Color {
    static let ccBlack = Color(.label)
    static let ccWhite = Color(.systemBackground)
    static let ccG50  = Color(red: 0.980, green: 0.980, blue: 0.980)
    static let ccG100 = Color(red: 0.961, green: 0.961, blue: 0.961)
    static let ccG150 = Color(red: 0.937, green: 0.937, blue: 0.937)
    static let ccG200 = Color(red: 0.910, green: 0.910, blue: 0.910)
    static let ccG300 = Color(red: 0.816, green: 0.816, blue: 0.816)
    static let ccG400 = Color(red: 0.627, green: 0.627, blue: 0.627)
    static let ccG500 = Color(red: 0.416, green: 0.416, blue: 0.416)
    static let ccG600 = Color(red: 0.227, green: 0.227, blue: 0.227)
}

enum CCAnim {
    static let spring = Animation.spring(response: 0.4, dampingFraction: 0.78)
    static let snappy = Animation.spring(response: 0.28, dampingFraction: 0.85)
    static let smooth = Animation.easeOut(duration: 0.25)
}

struct PressScaleStyle: ButtonStyle {
    var scale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .animation(CCAnim.snappy, value: configuration.isPressed)
    }
}

// Subtle B&W gradient textures
extension LinearGradient {
    static let heroDark = LinearGradient(
        colors: [Color(white: 0.04), Color(white: 0.10), Color(white: 0.04)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let glassLight = LinearGradient(
        colors: [Color.white.opacity(0.6), Color.white.opacity(0.2)],
        startPoint: .top, endPoint: .bottom
    )
}

// Card surface
struct CardStyle: ViewModifier {
    var radius: CGFloat = 20
    func body(content: Content) -> some View {
        content
            .background(Color.ccWhite)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .stroke(Color.ccG150, lineWidth: 0.6)
            )
            .shadow(color: Color.black.opacity(0.04), radius: 12, x: 0, y: 4)
    }
}

extension View {
    func ccCard(radius: CGFloat = 20) -> some View { modifier(CardStyle(radius: radius)) }
}

// Haptics helper
enum Haptic {
    static func tap(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
    static func select() { UISelectionFeedbackGenerator().selectionChanged() }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Root
// ════════════════════════════════════════════════════════════════════

struct ContentView: View {
    @AppStorage("appVersion") private var appVersion: String = "v2"
    var body: some View {
        Group {
            if appVersion == "v1" {
                V1RootView()
            } else {
                V2RootView()
            }
        }
        .animation(CCAnim.smooth, value: appVersion)
    }
}

// MARK: - V1 Root (Apple-minimal redesign baseline, locked at git tag v1.0)

struct V1RootView: View {
    @State private var isSignedIn = false

    var body: some View {
        ZStack {
            if isSignedIn {
                MainShell(onLogout: { withAnimation(CCAnim.smooth) { isSignedIn = false } })
                    .transition(.opacity)
            } else {
                LoginView(onLogin: { withAnimation(CCAnim.smooth) { isSignedIn = true } })
                    .transition(.opacity)
            }
        }
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Login
// ════════════════════════════════════════════════════════════════════

struct LoginView: View {
    var onLogin: () -> Void
    @State private var identifier = ""
    @State private var password = ""
    @FocusState private var focused: Field?
    enum Field { case id, pw }

    var body: some View {
        ZStack {
            Color.ccWhite.ignoresSafeArea()
            // Subtle B&W texture
            RadialGradient(
                colors: [Color.ccG100.opacity(0.6), Color.clear],
                center: .topTrailing, startRadius: 40, endRadius: 360
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()
                VStack(spacing: 14) {
                    Text("CRIBCREWW")
                        .font(.system(size: 44, weight: .black))
                        .tracking(-1.6)
                        .foregroundColor(.ccBlack)
                    Rectangle()
                        .fill(Color.ccBlack)
                        .frame(width: 28, height: 1.5)
                    Text("Your city. Your vibe.")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.ccG500)
                        .tracking(0.2)
                }
                Spacer()

                VStack(spacing: 12) {
                    LoginField(text: $identifier, placeholder: "Phone, username or email", focus: $focused, value: .id, isSecure: false)
                    LoginField(text: $password, placeholder: "Password", focus: $focused, value: .pw, isSecure: true)

                    HStack {
                        Spacer()
                        Text("Forgot password?")
                            .font(.system(size: 12.5, weight: .medium))
                            .foregroundColor(.ccG500)
                    }
                    .padding(.top, 2)

                    Button {
                        Haptic.tap(.medium)
                        onLogin()
                    } label: {
                        HStack(spacing: 8) {
                            Text("Continue")
                            Image(systemName: "arrow.right")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .tracking(-0.2)
                        .foregroundColor(.ccWhite)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 17)
                        .background(Color.ccBlack)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .buttonStyle(PressScaleStyle())
                    .padding(.top, 10)

                    HStack(spacing: 14) {
                        Rectangle().fill(Color.ccG200).frame(height: 0.6)
                        Text("OR")
                            .font(.system(size: 11, weight: .bold))
                            .tracking(2)
                            .foregroundColor(.ccG400)
                        Rectangle().fill(Color.ccG200).frame(height: 0.6)
                    }
                    .padding(.vertical, 10)

                    SocialBtn(systemImage: "applelogo", label: "Continue with Apple", filled: true) { onLogin() }
                    SocialBtn(systemImage: "g.circle.fill", label: "Continue with Google", filled: false) { onLogin() }
                }

                Spacer()

                HStack(spacing: 6) {
                    Text("New here?").foregroundColor(.ccG500)
                    Text("Join the crew")
                        .fontWeight(.semibold)
                        .foregroundColor(.ccBlack)
                        .onTapGesture { onLogin() }
                }
                .font(.system(size: 13))
                .padding(.bottom, 8)
            }
            .padding(.horizontal, 28)
        }
    }
}

struct LoginField: View {
    @Binding var text: String
    let placeholder: String
    @FocusState.Binding var focus: LoginView.Field?
    let value: LoginView.Field
    let isSecure: Bool

    var body: some View {
        HStack {
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
            }
            .focused($focus, equals: value)
            .font(.system(size: 15, weight: .medium))
        }
        .padding(.horizontal, 18).padding(.vertical, 16)
        .background(Color.ccG50)
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(focus == value ? Color.ccBlack : Color.ccG200, lineWidth: focus == value ? 1.4 : 0.8)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .animation(CCAnim.snappy, value: focus)
    }
}

struct SocialBtn: View {
    let systemImage: String
    let label: String
    let filled: Bool
    let action: () -> Void
    var body: some View {
        Button {
            Haptic.tap()
            action()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: systemImage)
                    .font(.system(size: 17, weight: .medium))
                Text(label).font(.system(size: 14.5, weight: .semibold))
            }
            .foregroundColor(filled ? .ccWhite : .ccBlack)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(filled ? Color.ccBlack : Color.ccWhite)
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(filled ? Color.clear : Color.ccG200, lineWidth: 0.8)
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .buttonStyle(PressScaleStyle())
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Main Shell + Floating Tab Bar
// ════════════════════════════════════════════════════════════════════

enum AppTab: Int, CaseIterable {
    case explore = 0, clubs, pulse, gossip, you
    var symbol: String {
        switch self {
        case .explore: return "magnifyingglass"
        case .clubs:   return "person.2.fill"
        case .pulse:   return "waveform.path"
        case .gossip:  return "bubble.left.and.bubble.right.fill"
        case .you:     return "person.crop.circle"
        }
    }
    var label: String {
        switch self {
        case .explore: return "Explore"
        case .clubs:   return "Clubs"
        case .pulse:   return "Pulse"
        case .gossip:  return "Gossip"
        case .you:     return "You"
        }
    }
}

struct MainShell: View {
    var onLogout: () -> Void
    @State private var tab: AppTab = .pulse

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch tab {
                case .explore: ExploreView()
                case .clubs:   ClubsView()
                case .pulse:   PulseView()
                case .gossip:  GossipView()
                case .you:     ProfileView(onLogout: onLogout)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .transition(.opacity)

            FloatingTabBar(selection: $tab)
                .padding(.horizontal, 18)
                .padding(.bottom, 6)
        }
        .background(Color.ccWhite.ignoresSafeArea())
    }
}

struct FloatingTabBar: View {
    @Binding var selection: AppTab
    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases, id: \.self) { t in
                Button {
                    if selection != t {
                        Haptic.select()
                        withAnimation(CCAnim.spring) { selection = t }
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: selection == t ? "\(t.symbol).fill" : t.symbol)
                            .font(.system(size: 18, weight: selection == t ? .semibold : .regular))
                            .symbolRenderingMode(.monochrome)
                            .frame(height: 22)
                        if selection == t {
                            Text(t.label)
                                .font(.system(size: 10, weight: .semibold))
                                .tracking(0.1)
                        }
                    }
                    .foregroundColor(selection == t ? .ccBlack : .ccG400)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 6).padding(.vertical, 4)
        .background(.ultraThinMaterial)
        .overlay(
            Capsule()
                .stroke(Color.ccG150, lineWidth: 0.6)
        )
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.10), radius: 24, x: 0, y: 10)
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Reusable Pieces
// ════════════════════════════════════════════════════════════════════

struct GreetingHeader: View {
    let title: String
    let subtitle: String
    var trailing: AnyView? = nil
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 30, weight: .black))
                    .tracking(-1)
                    .foregroundColor(.ccBlack)
                Text(subtitle)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.ccG500)
            }
            Spacer()
            HStack(spacing: 8) {
                if let t = trailing { t }
                ThemeToggle()
            }
            .padding(.top, 4)
        }
        .padding(.horizontal, 24).padding(.top, 14).padding(.bottom, 16)
    }
}

struct SectionLabel: View {
    let text: String
    var trailing: String? = nil
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 11, weight: .bold))
                .tracking(1.6)
                .foregroundColor(.ccG500)
            Spacer()
            if let t = trailing {
                HStack(spacing: 4) {
                    Text(t)
                    Image(systemName: "chevron.right").font(.system(size: 9, weight: .semibold))
                }
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.ccG400)
            }
        }
        .padding(.horizontal, 24).padding(.bottom, 12)
    }
}

struct ThemeToggle: View {
    @AppStorage("cc-theme") private var themeRaw: String = "light"
    var body: some View {
        Button {
            Haptic.tap()
            themeRaw = (themeRaw == "light") ? "dark" : "light"
        } label: {
            Image(systemName: themeRaw == "light" ? "moon" : "sun.max")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.ccBlack)
                .frame(width: 36, height: 36)
                .background(Color.ccG100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.ccG200, lineWidth: 0.5))
        }
        .buttonStyle(PressScaleStyle())
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Models
// ════════════════════════════════════════════════════════════════════

struct PulseSpot: Identifiable, Hashable {
    let id = UUID()
    let rank: Int
    let name: String
    let area: String
    let detail: String
    let tags: [String]
    let intensity: Double
    let label: String
    let liveCount: Int
}

struct Club: Identifiable, Hashable {
    let id = UUID()
    let icon: String
    let name: String
    let meta: String
    let tags: [String]
}

struct GossipTopic: Identifiable, Hashable {
    let id = UUID()
    let rank: Int
    let emoji: String
    let name: String
    let count: String
    let hot: Bool
}

struct ExploreCategory: Identifiable {
    let id = UUID()
    let label: String
    let emoji: String
    let count: String
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Pulse (Editorial Hero Layout)
// ════════════════════════════════════════════════════════════════════

struct PulseView: View {
    @State private var liveTotal: Int = 4_281

    let spots: [PulseSpot] = [
        .init(rank: 1, name: "Sector 29 Night Fest", area: "Sector 29",
              detail: "2,841 people here right now",
              tags: ["Music", "Food", "Open-air"], intensity: 0.95, label: "PEAK", liveCount: 2_841),
        .init(rank: 2, name: "Cyber Hub Brunch", area: "Cyber Hub",
              detail: "1,204 people here now",
              tags: ["Brunch", "Vibes"], intensity: 0.72, label: "HIGH", liveCount: 1_204),
        .init(rank: 3, name: "DLF Sunday Flea", area: "DLF Phase 1",
              detail: "876 people exploring",
              tags: ["Shop", "Art"], intensity: 0.48, label: "MED", liveCount: 876),
        .init(rank: 4, name: "Ambience Food Court", area: "NH48",
              detail: "643 people dining",
              tags: ["Food", "Family"], intensity: 0.35, label: "MED", liveCount: 643),
        .init(rank: 5, name: "Leisure Valley Run", area: "Sector 29",
              detail: "412 active right now",
              tags: ["Run", "Fitness"], intensity: 0.28, label: "LOW", liveCount: 412),
    ]

    var greetingTitle: String {
        let h = Calendar.current.component(.hour, from: Date())
        switch h {
        case 5..<12: return "Morning, Gurgaon"
        case 12..<17: return "Afternoon vibes"
        case 17..<22: return "Tonight in Gurgaon"
        default: return "Late nights"
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    GreetingHeader(
                        title: greetingTitle,
                        subtitle: "\(liveTotal.formatted()) people active right now",
                        trailing: AnyView(PulseLiveDot())
                    )

                    // HERO
                    PulseHero(spot: spots[0])
                        .padding(.horizontal, 20)
                        .padding(.bottom, 28)

                    SectionLabel(text: "TRENDING NOW", trailing: "See all")

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(spots.prefix(4)) { spot in
                                NavigationLink(value: spot) { TrendingPill(spot: spot) }
                                    .buttonStyle(PressScaleStyle())
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    .padding(.bottom, 28)

                    SectionLabel(text: "MORE TONIGHT")

                    VStack(spacing: 10) {
                        ForEach(spots.dropFirst()) { spot in
                            NavigationLink(value: spot) { PulseRow(spot: spot) }
                                .buttonStyle(PressScaleStyle())
                        }
                    }
                    .padding(.horizontal, 20)

                    Spacer().frame(height: 120)  // space for floating tab bar
                }
            }
            .background(Color.ccWhite.ignoresSafeArea())
            .scrollIndicators(.hidden)
            .refreshable {
                Haptic.tap(.light)
                try? await Task.sleep(nanoseconds: 700_000_000)
                liveTotal += Int.random(in: -120...300)
            }
            .navigationDestination(for: PulseSpot.self) { spot in
                ChatView(title: spot.name, subtitle: "\(spot.area) · \(spot.label)", initialLiveCount: spot.liveCount)
            }
        }
    }
}

struct PulseLiveDot: View {
    @State private var pulse = false
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(Color.ccBlack)
                .frame(width: 7, height: 7)
                .opacity(pulse ? 0.25 : 1)
            Text("LIVE")
                .font(.system(size: 10, weight: .bold))
                .tracking(1.5)
                .foregroundColor(.ccBlack)
        }
        .padding(.horizontal, 10).padding(.vertical, 6)
        .background(Color.ccG100)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.ccG200, lineWidth: 0.5))
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
    }
}

struct PulseHero: View {
    let spot: PulseSpot
    @State private var liveCount: Int

    init(spot: PulseSpot) {
        self.spot = spot
        self._liveCount = State(initialValue: spot.liveCount)
    }

    var body: some View {
        NavigationLink(value: spot) {
            ZStack(alignment: .bottomLeading) {
                // Layered gradient background
                LinearGradient.heroDark
                RadialGradient(
                    colors: [Color.white.opacity(0.10), Color.clear],
                    center: .topLeading, startRadius: 20, endRadius: 280
                )
                RadialGradient(
                    colors: [Color.white.opacity(0.06), Color.clear],
                    center: .bottomTrailing, startRadius: 20, endRadius: 220
                )

                // Top bar
                VStack {
                    HStack {
                        HStack(spacing: 5) {
                            Circle().fill(Color.white).frame(width: 6, height: 6)
                            Text(spot.label)
                                .font(.system(size: 10, weight: .bold))
                                .tracking(1.5)
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 10).padding(.vertical, 5)
                        .background(Color.white.opacity(0.12))
                        .overlay(Capsule().stroke(Color.white.opacity(0.15), lineWidth: 0.6))
                        .clipShape(Capsule())
                        Spacer()
                        VStack(alignment: .trailing, spacing: -2) {
                            Text("\(liveCount.formatted())")
                                .font(.system(size: 32, weight: .black))
                                .tracking(-1)
                                .foregroundColor(.white)
                                .contentTransition(.numericText(value: Double(liveCount)))
                            Text("here now")
                                .font(.system(size: 10, weight: .semibold))
                                .tracking(0.5)
                                .foregroundColor(.white.opacity(0.5))
                        }
                    }
                    Spacer()
                }
                .padding(20)

                // Bottom content
                VStack(alignment: .leading, spacing: 10) {
                    Text(spot.area.uppercased())
                        .font(.system(size: 10, weight: .bold))
                        .tracking(2)
                        .foregroundColor(.white.opacity(0.5))
                    Text(spot.name)
                        .font(.system(size: 26, weight: .black))
                        .tracking(-0.8)
                        .foregroundColor(.white)
                        .lineLimit(2)
                    HStack(spacing: 6) {
                        ForEach(spot.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.system(size: 10.5, weight: .semibold))
                                .padding(.horizontal, 9).padding(.vertical, 4)
                                .background(Color.white.opacity(0.10))
                                .overlay(Capsule().stroke(Color.white.opacity(0.18), lineWidth: 0.6))
                                .foregroundColor(.white.opacity(0.85))
                                .clipShape(Capsule())
                        }
                    }
                    HStack {
                        Spacer()
                        HStack(spacing: 6) {
                            Text("Join the chat")
                                .font(.system(size: 12, weight: .semibold))
                            Image(systemName: "arrow.right").font(.system(size: 10, weight: .bold))
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 14).padding(.vertical, 9)
                        .background(Color.white)
                        .clipShape(Capsule())
                    }
                    .padding(.top, 4)
                }
                .padding(20)
            }
            .frame(height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            .shadow(color: Color.black.opacity(0.18), radius: 28, x: 0, y: 14)
        }
        .buttonStyle(PressScaleStyle(scale: 0.985))
        .onAppear {
            // Subtle live count drift
            Task { @MainActor in
                while !Task.isCancelled {
                    try? await Task.sleep(nanoseconds: 2_500_000_000)
                    withAnimation(.easeInOut(duration: 0.8)) {
                        liveCount = max(0, liveCount + Int.random(in: -8...14))
                    }
                }
            }
        }
    }
}

struct TrendingPill: View {
    let spot: PulseSpot
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 5) {
                Circle().fill(Color.ccBlack).frame(width: 5, height: 5)
                Text(spot.label)
                    .font(.system(size: 9, weight: .bold))
                    .tracking(1.2)
                    .foregroundColor(.ccBlack)
            }
            Text(spot.name)
                .font(.system(size: 14, weight: .bold))
                .tracking(-0.3)
                .foregroundColor(.ccBlack)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Spacer()
            HStack(spacing: 4) {
                Image(systemName: "person.2.fill")
                    .font(.system(size: 9))
                Text(spot.liveCount.formatted())
                    .font(.system(size: 11, weight: .semibold))
            }
            .foregroundColor(.ccG500)
        }
        .frame(width: 150, height: 130, alignment: .topLeading)
        .padding(14)
        .ccCard(radius: 18)
    }
}

struct PulseRow: View {
    let spot: PulseSpot
    var body: some View {
        HStack(spacing: 14) {
            Text("\(spot.rank)")
                .font(.system(size: 28, weight: .black))
                .tracking(-1)
                .foregroundColor(.ccG200)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 4) {
                Text(spot.name)
                    .font(.system(size: 15, weight: .bold))
                    .tracking(-0.3)
                    .foregroundColor(.ccBlack)
                HStack(spacing: 6) {
                    Text(spot.area)
                        .font(.system(size: 11.5, weight: .medium))
                        .foregroundColor(.ccG500)
                    Text("·").foregroundColor(.ccG300)
                    Text("\(spot.liveCount.formatted()) here")
                        .font(.system(size: 11.5, weight: .medium))
                        .foregroundColor(.ccG500)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.ccG150).frame(width: 44, height: 4)
                    Capsule().fill(Color.ccBlack).frame(width: 44 * spot.intensity, height: 4)
                }
                Text(spot.label)
                    .font(.system(size: 9.5, weight: .bold))
                    .tracking(0.8)
                    .foregroundColor(.ccG500)
            }
        }
        .padding(16)
        .ccCard(radius: 18)
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Clubs
// ════════════════════════════════════════════════════════════════════

struct ClubsView: View {
    let publicClubs: [Club] = [
        .init(icon: "🏃", name: "Run Club Gurgaon", meta: "2,340 members · Daily 5:45 AM", tags: ["POPULAR"]),
        .init(icon: "💪", name: "Fitness Squad DLF", meta: "1,820 members · Active daily", tags: ["ACTIVE"]),
        .init(icon: "💃", name: "Dance Circle", meta: "940 members · Weekly", tags: ["OPEN"]),
        .init(icon: "🎵", name: "Music Collective", meta: "1,150 members · Weekend jams", tags: ["OPEN"]),
        .init(icon: "🥊", name: "Fight Club GGN", meta: "620 members · MMA & boxing", tags: ["INVITE"]),
        .init(icon: "🍕", name: "Food Explorers", meta: "3,100 members · Most active", tags: ["POPULAR"]),
        .init(icon: "📸", name: "Photo Walks", meta: "780 members · Weekend walks", tags: ["OPEN"]),
        .init(icon: "🎮", name: "Gaming Crew", meta: "2,200 members · Online & IRL", tags: ["ACTIVE"]),
    ]
    let privateClubs: [Club] = [
        .init(icon: "🎓", name: "Presidency University", meta: "Private · 4,200 students", tags: ["VERIFIED"]),
        .init(icon: "🏛️", name: "Amity University Noida", meta: "Private · 8,900 students", tags: ["VERIFIED"]),
        .init(icon: "📚", name: "BITS Pilani Gurgaon", meta: "Private · 2,100 students", tags: ["VERIFIED"]),
        .init(icon: "🏫", name: "MDI Gurgaon Alumni", meta: "Private · 680 members", tags: ["INVITE"]),
        .init(icon: "🔬", name: "IIT Delhi Alumni", meta: "Private · Invite only", tags: ["INVITE"]),
        .init(icon: "🏦", name: "DLF Founders Circle", meta: "Private · Founders only", tags: ["EXCLUSIVE"]),
    ]
    @State private var tab = 0

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                GreetingHeader(title: "Clubs", subtitle: "Your crew, in one place")

                // Segmented
                HStack(spacing: 0) {
                    SegItem(label: "Public", active: tab == 0) {
                        Haptic.select(); withAnimation(CCAnim.snappy) { tab = 0 }
                    }
                    SegItem(label: "Private", active: tab == 1) {
                        Haptic.select(); withAnimation(CCAnim.snappy) { tab = 1 }
                    }
                }
                .padding(4)
                .background(Color.ccG100)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .padding(.horizontal, 24).padding(.bottom, 18)

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(tab == 0 ? publicClubs : privateClubs) { c in
                            NavigationLink(value: c) { ClubRow(club: c) }
                                .buttonStyle(PressScaleStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    Spacer().frame(height: 120)
                }
                .scrollIndicators(.hidden)
            }
            .background(Color.ccWhite.ignoresSafeArea())
            .navigationDestination(for: Club.self) { c in
                ChatView(title: c.name, subtitle: c.meta, initialLiveCount: Int.random(in: 80...340))
            }
        }
    }
}

struct SegItem: View {
    let label: String
    let active: Bool
    let onTap: () -> Void
    var body: some View {
        Button(action: onTap) {
            Text(label)
                .font(.system(size: 13.5, weight: .semibold))
                .foregroundColor(active ? .ccWhite : .ccG500)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 9)
                .background(active ? Color.ccBlack : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

struct ClubRow: View {
    let club: Club
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                LinearGradient.heroDark
                Text(club.icon).font(.system(size: 22))
            }
            .frame(width: 52, height: 52)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(club.name)
                    .font(.system(size: 15, weight: .bold))
                    .tracking(-0.3)
                    .foregroundColor(.ccBlack)
                Text(club.meta)
                    .font(.system(size: 11.5, weight: .medium))
                    .foregroundColor(.ccG500)
                HStack(spacing: 5) {
                    ForEach(club.tags, id: \.self) { tag in
                        let isPrimary = (tag == "POPULAR" || tag == "EXCLUSIVE" || tag == "VERIFIED")
                        Text(tag)
                            .font(.system(size: 9.5, weight: .bold))
                            .tracking(0.8)
                            .padding(.horizontal, 8).padding(.vertical, 3)
                            .background(isPrimary ? Color.ccBlack : Color.ccG100)
                            .foregroundColor(isPrimary ? .ccWhite : .ccG600)
                            .clipShape(Capsule())
                    }
                }
                .padding(.top, 2)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.ccG300)
        }
        .padding(14)
        .ccCard(radius: 18)
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Gossip
// ════════════════════════════════════════════════════════════════════

struct GossipView: View {
    let topics: [GossipTopic] = [
        .init(rank: 1, emoji: "🏏", name: "RCB vs CSK — The Rivalry Heats Up", count: "24.6K", hot: true),
        .init(rank: 2, emoji: "⚡", name: "Trump–Iran — What Happens Next?", count: "18.9K", hot: false),
        .init(rank: 3, emoji: "🤖", name: "AI Is Taking Our Jobs — Myth or Reality?", count: "14.2K", hot: false),
        .init(rank: 4, emoji: "🚇", name: "Gurgaon Metro Phase 2 — Finally Real?", count: "11.7K", hot: false),
        .init(rank: 5, emoji: "💔", name: "Bollywood Breakup Season Is Back", count: "9.4K", hot: false),
        .init(rank: 6, emoji: "🏋️", name: "Fitness Culture in Gurgaon Is Exploding", count: "7.8K", hot: false),
        .init(rank: 7, emoji: "🎓", name: "CUET 2025 Results Controversy", count: "6.1K", hot: false),
        .init(rank: 8, emoji: "💰", name: "India's GDP Hits $5T — Now What?", count: "5.3K", hot: false),
    ]
    @State private var query = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                GreetingHeader(title: "Gossip", subtitle: "What the world is talking about")

                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.ccG400)
                    TextField("Search any topic…", text: $query)
                        .font(.system(size: 14, weight: .medium))
                }
                .padding(.horizontal, 16).padding(.vertical, 13)
                .background(Color.ccG100)
                .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.ccG150, lineWidth: 0.6))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .padding(.horizontal, 24).padding(.bottom, 18)

                ScrollView {
                    SectionLabel(text: "🔥  TRENDING GLOBALLY")

                    VStack(spacing: 8) {
                        ForEach(topics) { t in
                            NavigationLink(value: t) { GossipRow(topic: t) }
                                .buttonStyle(PressScaleStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    Spacer().frame(height: 120)
                }
                .scrollIndicators(.hidden)
            }
            .background(Color.ccWhite.ignoresSafeArea())
            .navigationDestination(for: GossipTopic.self) { t in
                ChatView(title: t.name, subtitle: "💬 \(t.count) joined", initialLiveCount: 380)
            }
        }
    }
}

struct GossipRow: View {
    let topic: GossipTopic
    var body: some View {
        HStack(spacing: 14) {
            Text("\(topic.rank)")
                .font(.system(size: 22, weight: .black))
                .tracking(-1)
                .foregroundColor(topic.hot ? Color.white.opacity(0.18) : .ccG200)
                .frame(width: 22)

            VStack(alignment: .leading, spacing: 6) {
                Text(topic.name)
                    .font(.system(size: 14.5, weight: .bold))
                    .tracking(-0.3)
                    .foregroundColor(topic.hot ? .white : .ccBlack)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                HStack(spacing: 7) {
                    HStack(spacing: 4) {
                        Image(systemName: "bubble.left.fill").font(.system(size: 9))
                        Text(topic.count)
                    }
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(topic.hot ? Color.white.opacity(0.45) : .ccG400)
                    if topic.hot {
                        HStack(spacing: 4) {
                            Circle().fill(Color.white).frame(width: 5, height: 5)
                            Text("LIVE").tracking(0.8)
                        }
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.white.opacity(0.85))
                        .padding(.horizontal, 8).padding(.vertical, 2)
                        .background(Color.white.opacity(0.14))
                        .clipShape(Capsule())
                    }
                }
            }
            Spacer()
            Text(topic.emoji).font(.system(size: 22))
        }
        .padding(14)
        .background(topic.hot ? AnyShapeStyle(LinearGradient.heroDark) : AnyShapeStyle(Color.ccWhite))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(topic.hot ? Color.clear : Color.ccG150, lineWidth: 0.6)
        )
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: Color.black.opacity(topic.hot ? 0.18 : 0.04), radius: topic.hot ? 16 : 12, x: 0, y: topic.hot ? 8 : 4)
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Explore
// ════════════════════════════════════════════════════════════════════

struct ExploreView: View {
    let popular: [ExploreCategory] = [
        .init(label: "Food", emoji: "🍽️", count: "342 spots"),
        .init(label: "Nightlife", emoji: "🎉", count: "86 spots"),
        .init(label: "Cafes", emoji: "☕", count: "198 spots"),
        .init(label: "Co-work", emoji: "💻", count: "34 spots"),
    ]
    let categories: [ExploreCategory] = [
        .init(label: "Restaurants", emoji: "🍽️", count: "342"), .init(label: "Cafes", emoji: "☕", count: "198"),
        .init(label: "Parks", emoji: "🌳", count: "47"), .init(label: "Hotels", emoji: "🏨", count: "62"),
        .init(label: "Gyms", emoji: "💪", count: "84"), .init(label: "Nightlife", emoji: "🎉", count: "86"),
        .init(label: "Malls", emoji: "🛍️", count: "12"), .init(label: "Salons", emoji: "💈", count: "121"),
        .init(label: "Hospitals", emoji: "🏥", count: "38"), .init(label: "Pharmacy", emoji: "💊", count: "187"),
        .init(label: "Petrol", emoji: "⛽", count: "56"), .init(label: "Activity", emoji: "🎯", count: "29"),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    GreetingHeader(title: "Explore", subtitle: "Gurgaon · Haryana · ☀️ 34°C")

                    SectionLabel(text: "POPULAR RIGHT NOW", trailing: "See all")

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(popular) { c in PopularCard(category: c) }
                        }
                        .padding(.horizontal, 24)
                    }
                    .padding(.bottom, 28)

                    SectionLabel(text: "BROWSE GURGAON")

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 18) {
                        ForEach(categories) { c in CategoryCell(category: c) }
                    }
                    .padding(.horizontal, 24)

                    Spacer().frame(height: 120)
                }
            }
            .background(Color.ccWhite.ignoresSafeArea())
            .scrollIndicators(.hidden)
        }
    }
}

struct PopularCard: View {
    let category: ExploreCategory
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(category.emoji).font(.system(size: 26))
            Spacer()
            Text(category.label)
                .font(.system(size: 14, weight: .bold))
                .tracking(-0.3)
                .foregroundColor(.ccBlack)
            Text(category.count)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.ccG500)
        }
        .frame(width: 140, height: 140, alignment: .topLeading)
        .padding(16)
        .ccCard(radius: 20)
    }
}

struct CategoryCell: View {
    let category: ExploreCategory
    var body: some View {
        VStack(spacing: 8) {
            Text(category.emoji)
                .font(.system(size: 26))
                .frame(width: 64, height: 64)
                .background(Color.ccG100)
                .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(Color.ccG150, lineWidth: 0.6))
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            Text(category.label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.ccG600)
                .lineLimit(1)
        }
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Profile
// ════════════════════════════════════════════════════════════════════

struct ProfileView: View {
    var onLogout: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    GreetingHeader(title: "You", subtitle: "Devv · Gurgaon")

                    // Hero
                    VStack(spacing: 16) {
                        ZStack(alignment: .bottomTrailing) {
                            ZStack {
                                LinearGradient.heroDark
                                Text("🧑").font(.system(size: 38))
                            }
                            .frame(width: 96, height: 96)
                            .clipShape(Circle())
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.ccBlack)
                                .background(Color.ccWhite.clipShape(Circle()).padding(2))
                        }
                        Text("@devv")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.ccG500)

                        HStack(spacing: 0) {
                            ProfileStat(num: "3", label: "Clubs")
                            Divider().frame(height: 32).background(Color.ccG200)
                            ProfileStat(num: "1.4K", label: "Crew")
                            Divider().frame(height: 32).background(Color.ccG200)
                            ProfileStat(num: "89", label: "Posts")
                            Divider().frame(height: 32).background(Color.ccG200)
                            ProfileStat(num: "47", label: "Drops")
                        }
                        .padding(.vertical, 16).padding(.horizontal, 8)
                        .ccCard(radius: 20)
                        .padding(.horizontal, 20)
                    }
                    .padding(.vertical, 8)

                    Spacer().frame(height: 24)

                    ProfileSection(title: "MY CLUBS", items: [
                        ("🏃", "Run Club Gurgaon", nil),
                        ("🎓", "Presidency University", nil),
                        ("🍕", "Food Explorers", nil),
                    ])

                    ProfileSection(title: "ACTIVITY", items: [
                        ("📍", "Places Explored", "142"),
                        ("⚡", "My Drops", "47"),
                        ("💬", "Gossip Threads", "23"),
                    ])

                    ProfileSection(title: "SETTINGS", items: [
                        ("🔔", "Notifications", nil),
                        ("🔒", "Privacy", nil),
                    ])

                    AppVersionToggleRow()

                    Button {
                        Haptic.tap(.medium)
                        onLogout()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.right.square")
                                .font(.system(size: 15, weight: .semibold))
                            Text("Log Out")
                                .font(.system(size: 14.5, weight: .semibold))
                        }
                        .foregroundColor(.ccBlack)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.ccG100)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                    .buttonStyle(PressScaleStyle())
                    .padding(.horizontal, 20).padding(.top, 16)

                    Spacer().frame(height: 120)
                }
            }
            .background(Color.ccWhite.ignoresSafeArea())
            .scrollIndicators(.hidden)
        }
    }
}

struct ProfileStat: View {
    let num: String
    let label: String
    var body: some View {
        VStack(spacing: 3) {
            Text(num)
                .font(.system(size: 18, weight: .black))
                .tracking(-0.5)
                .foregroundColor(.ccBlack)
            Text(label)
                .font(.system(size: 10, weight: .semibold))
                .tracking(0.5)
                .foregroundColor(.ccG500)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfileSection: View {
    let title: String
    let items: [(String, String, String?)]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 11, weight: .bold))
                .tracking(1.6)
                .foregroundColor(.ccG500)
                .padding(.horizontal, 24).padding(.top, 18).padding(.bottom, 10)

            VStack(spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.offset) { idx, item in
                    HStack(spacing: 12) {
                        Text(item.0).font(.system(size: 18))
                            .frame(width: 40, height: 40)
                            .background(Color.ccG100)
                            .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                        Text(item.1)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.ccBlack)
                        Spacer()
                        if let detail = item.2 {
                            Text(detail)
                                .font(.system(size: 12.5, weight: .semibold))
                                .foregroundColor(.ccG500)
                        }
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.ccG300)
                    }
                    .padding(.horizontal, 16).padding(.vertical, 12)
                    if idx < items.count - 1 {
                        Rectangle().fill(Color.ccG100).frame(height: 1).padding(.leading, 68)
                    }
                }
            }
            .ccCard(radius: 18)
            .padding(.horizontal, 20)
        }
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Chat
// ════════════════════════════════════════════════════════════════════

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let author: String
    let avatar: String
    let text: String
    let isOwn: Bool
}

private let kIncomingPool: [(String, String, String)] = [
    ("Aarav", "A", "lol same exact thing happened to me"),
    ("Sneha", "S", "wait fr?? 🙃"),
    ("Karan", "K", "ok this place is unreal rn"),
    ("Riya", "R", "literally on my way over"),
    ("Devansh", "D", "post pics 🙌"),
    ("Megha", "M", "who else is going tonight??"),
    ("Arjun", "A", "just got here, line is insane"),
    ("Tara", "T", "the music tonight 🔥🔥"),
    ("Ishita", "I", "saw the whole crew there"),
    ("Rohan", "R", "anyone got a spare ticket"),
    ("Priya", "P", "drinks on me whoever shows up"),
    ("Kabir", "K", "imma pull up in 20"),
]

struct ChatView: View {
    let title: String
    let subtitle: String
    let initialLiveCount: Int

    @Environment(\.dismiss) private var dismiss
    @State private var messages: [ChatMessage] = [
        .init(author: "Vikram T.", avatar: "V", text: "yo who's pulling up tonight 👀", isOwn: false),
        .init(author: "Priya M.", avatar: "P", text: "I'm in. tagging the crew", isOwn: false),
        .init(author: "You", avatar: "Y", text: "be there in 30", isOwn: true),
        .init(author: "Anika R.", avatar: "A", text: "save me a spot 🙏", isOwn: false),
    ]
    @State private var input = ""
    @State private var typingUser: String? = nil
    @State private var liveCount = 0
    @State private var pulse = false
    @State private var simTask: Task<Void, Never>?

    var body: some View {
        VStack(spacing: 0) {
            // Custom header
            HStack(alignment: .center, spacing: 12) {
                Button {
                    Haptic.tap()
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.ccBlack)
                        .frame(width: 36, height: 36)
                        .background(Color.ccG100)
                        .clipShape(Circle())
                }
                .buttonStyle(PressScaleStyle())

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 15, weight: .bold))
                        .tracking(-0.3)
                        .foregroundColor(.ccBlack)
                        .lineLimit(1)
                    HStack(spacing: 6) {
                        Circle()
                            .fill(Color.ccBlack)
                            .frame(width: 6, height: 6)
                            .opacity(pulse ? 0.25 : 1)
                        Text("\(liveCount.formatted()) active")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.ccG500)
                            .contentTransition(.numericText(value: Double(liveCount)))
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16).padding(.vertical, 10)
            .background(.ultraThinMaterial)
            .overlay(Rectangle().fill(Color.ccG150).frame(height: 0.6), alignment: .bottom)

            // Messages
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 10) {
                        Spacer().frame(height: 8)
                        ForEach(messages) { msg in
                            MessageBubble(message: msg)
                                .id(msg.id)
                                .transition(.asymmetric(
                                    insertion: .opacity.combined(with: .move(edge: .bottom)),
                                    removal: .opacity
                                ))
                        }
                        if let user = typingUser {
                            TypingBubble(user: user)
                                .id("typing")
                                .transition(.opacity.combined(with: .move(edge: .leading)))
                        }
                        Color.clear.frame(height: 1).id("bottom")
                    }
                    .padding(.horizontal, 20)
                }
                .scrollIndicators(.hidden)
                .onChange(of: messages.count) { _, _ in
                    withAnimation(.easeOut(duration: 0.28)) {
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                }
                .onChange(of: typingUser) { _, _ in
                    withAnimation { proxy.scrollTo("bottom", anchor: .bottom) }
                }
            }

            // Input bar
            HStack(spacing: 10) {
                TextField("Say something to the crew…", text: $input)
                    .font(.system(size: 14.5, weight: .medium))
                    .padding(.horizontal, 18).padding(.vertical, 13)
                    .background(Color.ccG100)
                    .overlay(Capsule().stroke(Color.ccG200, lineWidth: 0.6))
                    .clipShape(Capsule())
                    .submitLabel(.send)
                    .onSubmit(send)

                Button(action: send) {
                    Image(systemName: input.isEmpty ? "mic.fill" : "arrow.up")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.ccWhite)
                        .frame(width: 44, height: 44)
                        .background(Color.ccBlack)
                        .clipShape(Circle())
                }
                .buttonStyle(PressScaleStyle())
                .animation(CCAnim.snappy, value: input.isEmpty)
            }
            .padding(.horizontal, 16).padding(.top, 10).padding(.bottom, 12)
            .background(Color.ccWhite)
            .overlay(Rectangle().fill(Color.ccG150).frame(height: 0.6), alignment: .top)
        }
        .background(Color.ccWhite.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            liveCount = initialLiveCount
            startPulse()
            startSimulation()
        }
        .onDisappear {
            simTask?.cancel()
        }
    }

    private func send() {
        let text = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        Haptic.tap(.medium)
        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
            messages.append(.init(author: "You", avatar: "Y", text: text, isOwn: true))
        }
        input = ""
    }

    private func startPulse() {
        Task { @MainActor in
            while !Task.isCancelled {
                withAnimation(.easeInOut(duration: 1.0)) { pulse.toggle() }
                try? await Task.sleep(nanoseconds: 1_000_000_000)
            }
        }
    }

    private func startSimulation() {
        simTask?.cancel()
        simTask = Task { @MainActor in
            while !Task.isCancelled {
                let delay = UInt64.random(in: 4_000_000_000...8_000_000_000)
                try? await Task.sleep(nanoseconds: delay)
                if Task.isCancelled { return }

                guard let pick = kIncomingPool.randomElement() else { continue }

                withAnimation { typingUser = "\(pick.0) is typing…" }
                try? await Task.sleep(nanoseconds: UInt64.random(in: 1_500_000_000...2_500_000_000))
                if Task.isCancelled { return }

                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    typingUser = nil
                    messages.append(.init(author: pick.0, avatar: pick.1, text: pick.2, isOwn: false))
                }

                let drift = Int.random(in: -3...8)
                withAnimation(.easeInOut(duration: 0.6)) {
                    liveCount = max(0, liveCount + drift)
                }
            }
        }
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.isOwn { Spacer(minLength: 50) }
            if !message.isOwn {
                Text(message.avatar)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.ccG600)
                    .frame(width: 30, height: 30)
                    .background(Color.ccG100)
                    .overlay(Circle().stroke(Color.ccG200, lineWidth: 0.6))
                    .clipShape(Circle())
            }
            VStack(alignment: message.isOwn ? .trailing : .leading, spacing: 3) {
                if !message.isOwn {
                    Text(message.author)
                        .font(.system(size: 9, weight: .bold))
                        .tracking(0.3)
                        .foregroundColor(.ccG400)
                }
                Text(message.text)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(message.isOwn ? .ccWhite : .ccBlack)
                    .padding(.horizontal, 14).padding(.vertical, 10)
                    .background(message.isOwn ? AnyShapeStyle(LinearGradient.heroDark) : AnyShapeStyle(Color.ccG100))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(message.isOwn ? Color.clear : Color.ccG200, lineWidth: 0.6)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            if !message.isOwn { Spacer(minLength: 50) }
        }
    }
}

struct TypingBubble: View {
    let user: String
    @State private var step = 0
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Circle().fill(Color.ccG100)
                .frame(width: 30, height: 30)
                .overlay(Circle().stroke(Color.ccG200, lineWidth: 0.6))
            HStack(spacing: 5) {
                ForEach(0..<3) { i in
                    Circle()
                        .fill(Color.ccG500)
                        .frame(width: 6, height: 6)
                        .offset(y: step == i ? -4 : 0)
                }
            }
            .padding(.horizontal, 14).padding(.vertical, 12)
            .background(Color.ccG100)
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.ccG200, lineWidth: 0.6))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            Spacer()
        }
        .onAppear {
            Task { @MainActor in
                while !Task.isCancelled {
                    try? await Task.sleep(nanoseconds: 250_000_000)
                    withAnimation(.easeInOut(duration: 0.2)) { step = (step + 1) % 3 }
                }
            }
        }
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - App Version Toggle (shared)
// ════════════════════════════════════════════════════════════════════

struct AppVersionToggleRow: View {
    @AppStorage("appVersion") private var appVersion: String = "v2"
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("APP VERSION")
                .font(.system(size: 11, weight: .bold))
                .tracking(1.6)
                .foregroundColor(.ccG500)
                .padding(.horizontal, 24).padding(.top, 18).padding(.bottom, 10)

            HStack(spacing: 0) {
                VersionPill(label: "v1.0", caption: "Baseline", active: appVersion == "v1") {
                    Haptic.select(); appVersion = "v1"
                }
                VersionPill(label: "v2.0", caption: "Two-Mode (PRD-led)", active: appVersion == "v2") {
                    Haptic.select(); appVersion = "v2"
                }
            }
            .padding(4)
            .background(Color.ccG100)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .padding(.horizontal, 20)

            Text("Switch instantly between versions. Both ship in the same build.")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.ccG400)
                .padding(.horizontal, 24).padding(.top, 8)
        }
    }
}

struct VersionPill: View {
    let label: String
    let caption: String
    let active: Bool
    let onTap: () -> Void
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 2) {
                Text(label)
                    .font(.system(size: 14, weight: .bold))
                    .tracking(-0.3)
                    .foregroundColor(active ? .ccWhite : .ccBlack)
                Text(caption)
                    .font(.system(size: 9.5, weight: .semibold))
                    .tracking(0.2)
                    .foregroundColor(active ? Color.white.opacity(0.6) : .ccG500)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(active ? Color.ccBlack : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - V2 FINAL — 3 tabs, 4 new hero features, full product redesign
// ════════════════════════════════════════════════════════════════════

extension Color {
    static let v2Cream      = Color(red: 0.984, green: 0.976, blue: 0.961)
    static let v2Paper      = Color(red: 1.000, green: 0.996, blue: 0.988)
    static let v2Stone      = Color(red: 0.953, green: 0.945, blue: 0.929)
    static let v2Hairline   = Color(red: 0.898, green: 0.882, blue: 0.851)
    static let v2Border     = Color(red: 0.847, green: 0.827, blue: 0.792)
    static let v2Ink        = Color(red: 0.055, green: 0.055, blue: 0.063)
    static let v2Coal       = Color(red: 0.243, green: 0.243, blue: 0.247)
    static let v2Mute       = Color(red: 0.420, green: 0.408, blue: 0.380)
    static let v2Soft       = Color(red: 0.604, green: 0.588, blue: 0.553)
    static let v2Amber      = Color(red: 0.722, green: 0.357, blue: 0.118)
    static let v2AmberDeep  = Color(red: 0.553, green: 0.235, blue: 0.063)
    static let v2Forest     = Color(red: 0.176, green: 0.459, blue: 0.325)
    static let v2Coral      = Color(red: 0.831, green: 0.271, blue: 0.271)
}

extension Font {
    static func vDisplay(_ size: CGFloat, _ weight: Font.Weight = .heavy) -> Font {
        .system(size: size, weight: weight, design: .serif)
    }
    static func vRound(_ size: CGFloat, _ weight: Font.Weight = .medium) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }
    static func vSans(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

struct VPress: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.92 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.78), value: configuration.isPressed)
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Root
// ════════════════════════════════════════════════════════════════════

struct V2RootView: View {
    @State private var isSignedIn = false
    var body: some View {
        ZStack {
            Color.v2Cream.ignoresSafeArea()
            if isSignedIn {
                V2Shell(onLogout: { withAnimation(.easeInOut(duration: 0.28)) { isSignedIn = false } })
                    .transition(.opacity)
            } else {
                V2LoginView(onLogin: { withAnimation(.easeInOut(duration: 0.28)) { isSignedIn = true } })
                    .transition(.opacity)
            }
        }
        .preferredColorScheme(.light)
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Login (editorial magazine cover)
// ════════════════════════════════════════════════════════════════════

struct V2LoginView: View {
    var onLogin: () -> Void
    var body: some View {
        ZStack {
            Color.v2Cream.ignoresSafeArea()
            RadialGradient(colors: [Color.v2Amber.opacity(0.10), .clear],
                            center: .topTrailing, startRadius: 50, endRadius: 380)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    HStack(spacing: 6) {
                        Circle().fill(Color.v2Amber).frame(width: 8, height: 8)
                        Text("CRIBCREWW")
                            .font(.vRound(11, .heavy)).tracking(2).foregroundColor(.v2Ink)
                    }
                    Spacer()
                    Text("GURGAON · ED. 01")
                        .font(.vRound(10, .bold)).tracking(1.5).foregroundColor(.v2Soft)
                }
                .padding(.horizontal, 28).padding(.top, 18)

                Spacer()

                VStack(alignment: .leading, spacing: 18) {
                    Text("ISSUE 01")
                        .font(.vRound(11, .heavy)).tracking(1.5).foregroundColor(.v2Amber)
                    Text("Your\ncity, in\nmotion.")
                        .font(.vDisplay(56, .black)).tracking(-2)
                        .foregroundColor(.v2Ink).lineSpacing(-6)
                    Text("A real-time, friends-first guide to what's happening in Gurgaon — written by the people who actually live here.")
                        .font(.vSans(14, .regular)).foregroundColor(.v2Mute)
                        .lineSpacing(3).padding(.trailing, 40)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 28)

                Spacer()

                VStack(spacing: 10) {
                    Button {
                        Haptic.tap(.medium); onLogin()
                    } label: {
                        HStack(spacing: 8) {
                            Text("Continue").font(.vRound(15.5, .bold))
                            Image(systemName: "arrow.right").font(.vRound(13, .bold))
                        }
                        .foregroundColor(.v2Cream)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 17)
                        .background(Color.v2Ink)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .buttonStyle(VPress())

                    HStack(spacing: 10) {
                        V2SocialBtn(systemImage: "applelogo", label: "Apple", action: onLogin)
                        V2SocialBtn(systemImage: "phone.fill", label: "Phone", action: onLogin)
                    }
                }
                .padding(.horizontal, 28).padding(.bottom, 18)

                Rectangle().fill(Color.v2Hairline).frame(height: 0.6).padding(.horizontal, 28)

                HStack {
                    Text("New here?").foregroundColor(.v2Mute)
                    Text("Join the crew").fontWeight(.bold).foregroundColor(.v2Ink)
                        .onTapGesture { onLogin() }
                    Spacer()
                    Text("v2.0").font(.vRound(10, .bold)).tracking(1).foregroundColor(.v2Soft)
                }
                .font(.vSans(13))
                .padding(.horizontal, 28).padding(.top, 14).padding(.bottom, 14)
            }
        }
    }
}

struct V2SocialBtn: View {
    let systemImage: String
    let label: String
    let action: () -> Void
    var body: some View {
        Button {
            Haptic.tap(); action()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: systemImage).font(.system(size: 15, weight: .semibold))
                Text(label).font(.vRound(13.5, .semibold))
            }
            .foregroundColor(.v2Ink)
            .frame(maxWidth: .infinity).padding(.vertical, 14)
            .background(Color.v2Paper)
            .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.v2Border, lineWidth: 0.8))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .buttonStyle(VPress())
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Shell — 3 tabs + center floating + button
// ════════════════════════════════════════════════════════════════════

enum V2Tab: Int, CaseIterable {
    case tonight, crews, you
    var symbol: String {
        switch self {
        case .tonight: return "sun.max"
        case .crews:   return "person.2"
        case .you:     return "person.crop.circle"
        }
    }
    var fillSymbol: String {
        switch self {
        case .tonight: return "sun.max.fill"
        case .crews:   return "person.2.fill"
        case .you:     return "person.crop.circle.fill"
        }
    }
    var label: String {
        switch self {
        case .tonight: return "Tonight"
        case .crews:   return "Crews"
        case .you:     return "You"
        }
    }
}

struct V2Shell: View {
    var onLogout: () -> Void
    @AppStorage("v2.cityMode") private var cityMode: String = "local"
    @State private var tab: V2Tab = .tonight
    @State private var showComposer = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.v2Cream.ignoresSafeArea()
            Group {
                switch tab {
                case .tonight: V2TonightView(cityMode: $cityMode)
                case .crews:   V2CrewsView()
                case .you:     V2YouView(onLogout: onLogout)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            V2TabBar(selection: $tab, onComposeTap: {
                Haptic.tap(.medium)
                showComposer = true
            })
        }
        .sheet(isPresented: $showComposer) {
            V2ComposerSheet().presentationDetents([.medium])
        }
    }
}

struct V2TabBar: View {
    @Binding var selection: V2Tab
    let onComposeTap: () -> Void
    @Namespace private var ns

    var body: some View {
        HStack(spacing: 0) {
            tabButton(.tonight)
            tabButton(.crews)

            // Center compose button
            Button(action: onComposeTap) {
                ZStack {
                    Circle()
                        .fill(Color.v2Ink)
                        .frame(width: 52, height: 52)
                        .shadow(color: Color.v2Ink.opacity(0.25), radius: 14, y: 6)
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.v2Cream)
                }
                .frame(maxWidth: .infinity)
                .offset(y: -10)
            }
            .buttonStyle(VPress())

            tabButton(.you)
            // 5th slot for symmetry — placeholder hidden item
            Color.clear.frame(maxWidth: .infinity).frame(height: 1).hidden()
        }
        .padding(.bottom, 14)
        .background(
            VStack(spacing: 0) {
                Rectangle().fill(Color.v2Hairline).frame(height: 0.6)
                Color.v2Paper
            }
            .ignoresSafeArea(edges: .bottom)
        )
    }

    @ViewBuilder
    func tabButton(_ t: V2Tab) -> some View {
        Button {
            if selection != t {
                Haptic.select()
                withAnimation(.spring(response: 0.32, dampingFraction: 0.78)) { selection = t }
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: selection == t ? t.fillSymbol : t.symbol)
                    .font(.system(size: 18, weight: selection == t ? .semibold : .regular))
                    .foregroundColor(selection == t ? .v2Ink : .v2Soft)
                if selection == t {
                    Circle().fill(Color.v2Amber).frame(width: 4, height: 4)
                        .matchedGeometryEffect(id: "dot", in: ns)
                } else {
                    Color.clear.frame(width: 4, height: 4)
                }
            }
            .frame(maxWidth: .infinity).padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - Composer Sheet (center + button)
// ════════════════════════════════════════════════════════════════════

struct V2ComposerSheet: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("What's the move?")
                    .font(.vDisplay(22, .black)).tracking(-0.5)
                    .foregroundColor(.v2Ink)
                Spacer()
                Button {
                    Haptic.tap(); dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.v2Mute)
                        .frame(width: 30, height: 30)
                        .background(Color.v2Stone).clipShape(Circle())
                }
            }
            .padding(.horizontal, 22).padding(.top, 22).padding(.bottom, 18)

            VStack(spacing: 10) {
                V2ComposeOption(emoji: "📍", title: "Drop a moment", sub: "Photo + line from where you are now")
                V2ComposeOption(emoji: "🤝", title: "Start a Go With", sub: "Pick a spot, your crew RSVPs in one tap")
                V2ComposeOption(emoji: "💬", title: "Ask the city", sub: "Pushed to verified locals near you")
            }
            .padding(.horizontal, 16)

            Spacer()
        }
        .background(Color.v2Cream.ignoresSafeArea())
        .preferredColorScheme(.light)
    }
}

struct V2ComposeOption: View {
    let emoji: String
    let title: String
    let sub: String
    var body: some View {
        Button {
            Haptic.tap(.medium)
        } label: {
            HStack(spacing: 14) {
                Text(emoji).font(.system(size: 26))
                    .frame(width: 52, height: 52)
                    .background(Color.v2Stone)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                VStack(alignment: .leading, spacing: 3) {
                    Text(title).font(.vRound(15, .bold)).foregroundColor(.v2Ink)
                    Text(sub).font(.vRound(11.5, .medium)).foregroundColor(.v2Mute)
                }
                Spacer()
                Image(systemName: "arrow.up.right").font(.system(size: 12, weight: .bold))
                    .foregroundColor(.v2Soft)
            }
            .padding(14)
            .background(Color.v2Paper)
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(VPress())
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - TONIGHT (Home) — the core loop
// ════════════════════════════════════════════════════════════════════

struct V2RightNow: Identifiable {
    let id = UUID()
    let user: String
    let avatar: String
    let spot: String
    let area: String
    let line: String
    let minutesAgo: Int
    let vibe: Int
}

struct V2Spot: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let area: String
    let liveCount: Int
    let vibe: Int  // 1-10
    let crewHere: Int
    let tags: [String]
    let isLocalsPick: Bool

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (l: V2Spot, r: V2Spot) -> Bool { l.id == r.id }
}

struct V2TonightView: View {
    @Binding var cityMode: String
    @State private var streakDays: Int = 23
    @State private var totalActive: Int = 4_281
    @State private var planChosen: Bool = false
    @State private var selectedPlan: String = ""

    let planOptions: [(String, String, String)] = [
        ("☕", "Coffee at Diggin", "Sector 39 · 12 min away"),
        ("🍻", "Sector 29 strip", "8 of crew going · PEAK"),
        ("🌳", "Aravalli sunset run", "5:45 PM · Bhag Club"),
    ]

    let crewPresence: [(String, String, String, Color)] = [
        ("A", "Aarav", "Cyber Hub", .v2Forest),
        ("S", "Sneha", "Diggin", .v2Forest),
        ("K", "Karan", "Sector 29", .v2Forest),
        ("R", "Riya", "Aravalli run", .v2Forest),
        ("D", "Devansh", "MGF Mall", .v2Forest),
    ]

    let rightNow: [V2RightNow] = [
        .init(user: "Aarav", avatar: "A", spot: "Cyber Hub", area: "DLF Cyber City",
              line: "Brunch line is 30 min, but the rooftop has space rn", minutesAgo: 4, vibe: 8),
        .init(user: "Sneha", avatar: "S", spot: "Diggin Cafe", area: "Sector 39",
              line: "Owner just dropped a new filter blend. Get the small.", minutesAgo: 12, vibe: 9),
        .init(user: "Karan", avatar: "K", spot: "Sector 29", area: "Sector 29",
              line: "Striker is empty rn, perfect window before 9", minutesAgo: 18, vibe: 7),
        .init(user: "Riya", avatar: "R", spot: "Aravalli Run", area: "Aravalli Park",
              line: "weather just turned, 26 of us starting now", minutesAgo: 3, vibe: 9),
    ]

    let spots: [V2Spot] = [
        .init(name: "Sector 29 Night Fest", area: "Sector 29", liveCount: 2_841, vibe: 9, crewHere: 8, tags: ["Music","Food"], isLocalsPick: false),
        .init(name: "Cyber Hub Brunch", area: "Cyber Hub", liveCount: 1_204, vibe: 8, crewHere: 3, tags: ["Brunch","Vibes"], isLocalsPick: false),
        .init(name: "Diggin Cafe", area: "Sector 39", liveCount: 47, vibe: 9, crewHere: 2, tags: ["Coffee"], isLocalsPick: true),
        .init(name: "DLF Sunday Flea", area: "DLF Phase 1", liveCount: 876, vibe: 7, crewHere: 1, tags: ["Shop"], isLocalsPick: false),
    ]

    var greeting: String {
        let h = Calendar.current.component(.hour, from: Date())
        switch h {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        case 17..<22: return "Tonight"
        default: return "Late hours"
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                V2Masthead(streak: streakDays, cityMode: $cityMode)
                    .padding(.horizontal, 22).padding(.top, 14).padding(.bottom, 14)

                // Editorial greeting
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 5) {
                        Circle().fill(Color.v2Coral).frame(width: 6, height: 6)
                        Text("\(totalActive.formatted()) ALIVE NOW")
                            .font(.vRound(10, .heavy)).tracking(1.4).foregroundColor(.v2Coral)
                    }
                    Text(greeting + ", Devv")
                        .font(.vDisplay(30, .black)).tracking(-1).foregroundColor(.v2Ink)
                }
                .padding(.horizontal, 22).padding(.bottom, 4)

                // Floating Ask-a-Local pill (visiting mode only)
                if cityMode == "traveler" {
                    V2AskLocalPill().padding(.horizontal, 22).padding(.top, 12)
                }

                // Section: Tonight's Plan
                V2SectionHeader(text: "Tonight's plan", trailing: planChosen ? "Locked" : "Pick one")
                    .padding(.top, 24).padding(.bottom, 14)
                V2TonightsPlan(options: planOptions, chosen: $planChosen, selected: $selectedPlan)
                    .padding(.horizontal, 16).padding(.bottom, 28)

                // Section: The Drop (daily curated)
                V2SectionHeader(text: "Today's Drop", trailing: "Aarav")
                    .padding(.bottom, 14)
                V2TheDrop()
                    .padding(.horizontal, 16).padding(.bottom, 28)

                // Section: Right Now feed (HERO new)
                V2SectionHeader(text: "Right now", trailing: "Live · 6h decay")
                    .padding(.bottom, 14)
                VStack(spacing: 10) {
                    ForEach(rightNow) { r in
                        V2RightNowCard(item: r)
                    }
                }
                .padding(.horizontal, 16).padding(.bottom, 28)

                // Section: Where your crew is
                V2SectionHeader(text: "Your crew", trailing: "5 online")
                    .padding(.bottom, 14)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(Array(crewPresence.enumerated()), id: \.offset) { _, c in
                            V2CrewPresenceCard(letter: c.0, name: c.1, location: c.2, color: c.3)
                        }
                    }
                    .padding(.horizontal, 22)
                }
                .padding(.bottom, 28)

                // Section: Vibe Map (spots ranked by vibe)
                V2SectionHeader(text: "Hottest right now", trailing: "Live")
                    .padding(.bottom, 14)
                VStack(spacing: 8) {
                    ForEach(spots) { s in
                        V2VibeSpotRow(spot: s)
                    }
                }
                .padding(.horizontal, 16)

                Spacer().frame(height: 110)
            }
        }
        .scrollIndicators(.hidden)
        .background(Color.v2Cream.ignoresSafeArea())
        .onAppear { startDrift() }
    }

    func startDrift() {
        Task { @MainActor in
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                withAnimation(.easeInOut(duration: 0.8)) {
                    totalActive = max(0, totalActive + Int.random(in: -40...80))
                }
            }
        }
    }
}

// MASTHEAD
struct V2Masthead: View {
    let streak: Int
    @Binding var cityMode: String
    var body: some View {
        HStack {
            HStack(spacing: 5) {
                Circle().fill(Color.v2Amber).frame(width: 6, height: 6)
                Text("CRIBCREWW").font(.vRound(10.5, .heavy)).tracking(2).foregroundColor(.v2Ink)
                Text("· GURGAON").font(.vRound(10.5, .semibold)).tracking(1.5).foregroundColor(.v2Soft)
            }
            Spacer()
            HStack(spacing: 0) {
                modeChip("Local", value: "local")
                modeChip("Visiting", value: "traveler")
            }
            .padding(2).background(Color.v2Stone).clipShape(Capsule())
            .overlay(Capsule().stroke(Color.v2Hairline, lineWidth: 0.6))

            HStack(spacing: 4) {
                Image(systemName: "flame.fill").font(.system(size: 11, weight: .bold))
                    .foregroundColor(.v2Amber)
                Text("\(streak)").font(.vRound(12, .heavy)).foregroundColor(.v2Ink)
            }
            .padding(.horizontal, 9).padding(.vertical, 5)
            .background(Color.v2Stone).clipShape(Capsule())
            .overlay(Capsule().stroke(Color.v2Hairline, lineWidth: 0.6))
        }
    }
    @ViewBuilder
    func modeChip(_ label: String, value: String) -> some View {
        Button {
            Haptic.select()
            withAnimation(.spring(response: 0.3, dampingFraction: 0.78)) { cityMode = value }
        } label: {
            Text(label).font(.vRound(10.5, .bold)).tracking(0.2)
                .foregroundColor(cityMode == value ? .v2Cream : .v2Mute)
                .padding(.horizontal, 10).padding(.vertical, 5)
                .background(cityMode == value ? Color.v2Ink : Color.clear)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

struct V2SectionHeader: View {
    let text: String
    var trailing: String? = nil
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(text)
                .font(.vDisplay(22, .black)).tracking(-0.6).foregroundColor(.v2Ink)
            Rectangle().fill(Color.v2Ink.opacity(0.12)).frame(height: 0.8)
                .padding(.horizontal, 8)
            if let t = trailing {
                Text(t.uppercased())
                    .font(.vRound(10, .bold)).tracking(1.2).foregroundColor(.v2Amber)
            }
        }
        .padding(.horizontal, 22)
    }
}

// HERO 1 — Tonight's Plan
struct V2TonightsPlan: View {
    let options: [(String, String, String)]
    @Binding var chosen: Bool
    @Binding var selected: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(chosen ? "You're in." : "Pick one move tonight.")
                .font(.vDisplay(24, .black)).tracking(-0.6)
                .foregroundColor(.v2Ink)
                .padding(.horizontal, 18).padding(.top, 18).padding(.bottom, 4)
            Text(chosen ? "We'll ping you 30 min before." : "One commitment. We hold you to it.")
                .font(.vSans(13)).foregroundColor(.v2Mute)
                .padding(.horizontal, 18).padding(.bottom, 14)

            if !chosen {
                VStack(spacing: 8) {
                    ForEach(Array(options.enumerated()), id: \.offset) { _, opt in
                        Button {
                            Haptic.tap(.medium)
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.78)) {
                                selected = opt.1; chosen = true
                            }
                        } label: {
                            HStack(spacing: 14) {
                                Text(opt.0).font(.system(size: 22))
                                    .frame(width: 44, height: 44)
                                    .background(Color.v2Stone)
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(opt.1).font(.vRound(14.5, .bold)).foregroundColor(.v2Ink)
                                    Text(opt.2).font(.vSans(11.5, .medium)).foregroundColor(.v2Mute)
                                }
                                Spacer()
                                Image(systemName: "arrow.up.right").font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.v2Ink.opacity(0.4))
                            }
                            .padding(12)
                            .background(Color.v2Cream)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
                        }
                        .buttonStyle(VPress())
                    }
                }
                .padding(.horizontal, 12).padding(.bottom, 14)
            } else {
                HStack(spacing: 14) {
                    ZStack {
                        Circle().fill(Color.v2Amber)
                        Image(systemName: "checkmark").font(.system(size: 18, weight: .bold)).foregroundColor(.v2Cream)
                    }
                    .frame(width: 48, height: 48)
                    VStack(alignment: .leading, spacing: 3) {
                        Text(selected).font(.vRound(14.5, .bold)).foregroundColor(.v2Ink)
                        Text("Locked in for tonight").font(.vSans(11.5, .medium)).foregroundColor(.v2Mute)
                    }
                    Spacer()
                    Button {
                        Haptic.tap()
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.78)) {
                            chosen = false; selected = ""
                        }
                    } label: {
                        Text("Change").font(.vRound(11.5, .bold)).foregroundColor(.v2Mute)
                            .padding(.horizontal, 12).padding(.vertical, 7)
                            .background(Color.v2Stone).clipShape(Capsule())
                    }
                    .buttonStyle(VPress())
                }
                .padding(14).padding(.horizontal, 4).padding(.bottom, 14)
            }
        }
        .background(Color.v2Paper)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 22, style: .continuous).stroke(Color.v2Border, lineWidth: 0.8))
        .shadow(color: Color.black.opacity(0.04), radius: 14, y: 6)
    }
}

// HERO 2 — The Drop
struct V2TheDrop: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 10) {
                ZStack {
                    Circle().fill(Color.v2Stone).frame(width: 36, height: 36)
                    Text("A").font(.vRound(14, .heavy)).foregroundColor(.v2Ink)
                }
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text("Aarav M.").font(.vRound(12.5, .bold)).foregroundColor(.v2Ink)
                        Image(systemName: "checkmark.seal.fill").font(.system(size: 10))
                            .foregroundColor(.v2Forest)
                    }
                    Text("Verified · DLF Phase 1 · 14 mo")
                        .font(.vRound(10.5, .medium)).foregroundColor(.v2Mute)
                }
                Spacer()
                Text("DAILY DROP")
                    .font(.vRound(9, .heavy)).tracking(1.2).foregroundColor(.v2Amber)
                    .padding(.horizontal, 9).padding(.vertical, 4)
                    .background(Color.v2Amber.opacity(0.10))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 18).padding(.top, 18).padding(.bottom, 14)

            Text("Diggin Cafe.")
                .font(.vDisplay(26, .black)).tracking(-0.7)
                .foregroundColor(.v2Ink)
                .padding(.horizontal, 18).padding(.bottom, 4)

            Text("Tucked behind Sector 39 market. Owner makes filter coffee himself. Open till 11. Skip the front — go through the back lane.")
                .font(.vSans(13.5)).foregroundColor(.v2Coal).lineSpacing(3)
                .padding(.horizontal, 18).padding(.bottom, 16)

            HStack(spacing: 8) {
                Button {
                    Haptic.tap(.medium)
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.up.right").font(.system(size: 11, weight: .bold))
                        Text("Save spot")
                    }
                    .font(.vRound(13, .bold)).foregroundColor(.v2Cream)
                    .padding(.horizontal, 14).padding(.vertical, 9)
                    .background(Color.v2Ink).clipShape(Capsule())
                }
                .buttonStyle(VPress())

                Button {
                    Haptic.tap()
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "person.2.fill").font(.system(size: 11, weight: .bold))
                        Text("Go with crew")
                    }
                    .font(.vRound(13, .bold)).foregroundColor(.v2Ink)
                    .padding(.horizontal, 14).padding(.vertical, 9)
                    .background(Color.v2Stone)
                    .overlay(Capsule().stroke(Color.v2Hairline, lineWidth: 0.6))
                    .clipShape(Capsule())
                }
                .buttonStyle(VPress())
                Spacer()
            }
            .padding(.horizontal, 18).padding(.bottom, 18)
        }
        .background(Color.v2Paper)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 22, style: .continuous).stroke(Color.v2Border, lineWidth: 0.8))
        .shadow(color: Color.black.opacity(0.04), radius: 14, y: 6)
    }
}

// HERO 3 — Right Now Card (live moments feed)
struct V2RightNowCard: View {
    let item: V2RightNow
    var ago: String { item.minutesAgo == 0 ? "now" : "\(item.minutesAgo) min ago" }
    var vibeColor: Color {
        if item.vibe >= 8 { return .v2Coral }
        if item.vibe >= 6 { return .v2Amber }
        return .v2Mute
    }
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle().fill(Color.v2Stone).frame(width: 40, height: 40)
                    .overlay(Circle().stroke(Color.v2Hairline, lineWidth: 0.6))
                Text(item.avatar).font(.vRound(15, .heavy)).foregroundColor(.v2Ink)
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 6) {
                    Text(item.user).font(.vRound(12.5, .bold)).foregroundColor(.v2Ink)
                    Text("·").foregroundColor(.v2Soft)
                    Text(item.spot).font(.vRound(12.5, .semibold)).foregroundColor(.v2Coal)
                    Spacer()
                    HStack(spacing: 3) {
                        Circle().fill(vibeColor).frame(width: 5, height: 5)
                        Text("\(item.vibe)").font(.vRound(11, .heavy)).foregroundColor(vibeColor)
                    }
                }
                Text(item.line).font(.vSans(13.5)).foregroundColor(.v2Ink)
                    .lineSpacing(3).fixedSize(horizontal: false, vertical: true)
                HStack {
                    Text("\(item.area) · \(ago)")
                        .font(.vRound(10.5, .medium)).foregroundColor(.v2Soft)
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.up.right").font(.system(size: 10, weight: .bold))
                        Text("Drop in")
                    }
                    .font(.vRound(11, .bold)).foregroundColor(.v2Amber)
                }
            }
        }
        .padding(14)
        .background(Color.v2Paper)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
    }
}

// HERO 4 — Crew Presence card
struct V2CrewPresenceCard: View {
    let letter: String
    let name: String
    let location: String
    let color: Color
    @State private var pulse = false
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                Circle().fill(Color.v2Stone).frame(width: 56, height: 56)
                    .overlay(Text(letter).font(.vRound(20, .heavy)).foregroundColor(.v2Ink))
                    .overlay(Circle().stroke(Color.v2Hairline, lineWidth: 0.6))
                ZStack {
                    Circle().fill(Color.v2Cream).frame(width: 14, height: 14)
                    Circle().fill(color).frame(width: 9, height: 9).opacity(pulse ? 0.5 : 1)
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                    pulse = true
                }
            }
            Text(name).font(.vRound(11.5, .bold)).foregroundColor(.v2Ink)
            Text(location).font(.vRound(10, .medium)).foregroundColor(.v2Mute).lineLimit(1)
        }
        .frame(width: 96)
        .padding(.vertical, 12)
        .background(Color.v2Paper)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
    }
}

// HERO 5 — Vibe Spot Row (replaces star reviews)
struct V2VibeSpotRow: View {
    let spot: V2Spot
    var vibeColor: Color {
        if spot.vibe >= 8 { return .v2Coral }
        if spot.vibe >= 6 { return .v2Amber }
        return .v2Forest
    }
    var body: some View {
        HStack(spacing: 14) {
            // Big vibe score
            VStack(spacing: 1) {
                Text("\(spot.vibe)")
                    .font(.vDisplay(26, .black)).tracking(-1).foregroundColor(vibeColor)
                Text("VIBE")
                    .font(.vRound(8, .heavy)).tracking(1).foregroundColor(.v2Soft)
            }
            .frame(width: 44)

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(spot.name).font(.vRound(14.5, .bold)).foregroundColor(.v2Ink).lineLimit(1)
                    if spot.isLocalsPick {
                        HStack(spacing: 3) {
                            Image(systemName: "star.fill").font(.system(size: 7))
                            Text("LOCALS")
                        }
                        .font(.vRound(8, .heavy)).tracking(1)
                        .foregroundColor(.v2Forest)
                        .padding(.horizontal, 6).padding(.vertical, 2)
                        .background(Color.v2Forest.opacity(0.08)).clipShape(Capsule())
                    }
                }
                HStack(spacing: 6) {
                    Text(spot.area).font(.vRound(11.5, .semibold)).foregroundColor(.v2Mute)
                    Text("·").foregroundColor(.v2Soft)
                    Text("\(spot.liveCount.formatted()) here").font(.vRound(11.5, .medium)).foregroundColor(.v2Mute)
                    if spot.crewHere > 0 {
                        Text("·").foregroundColor(.v2Soft)
                        HStack(spacing: 3) {
                            Image(systemName: "person.2.fill").font(.system(size: 8))
                            Text("\(spot.crewHere) crew")
                        }
                        .font(.vRound(11, .bold)).foregroundColor(.v2Forest)
                    }
                }
            }
            Spacer()
            Button {
                Haptic.tap(.medium)
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "person.2.fill").font(.system(size: 9, weight: .bold))
                    Text("Go With")
                }
                .font(.vRound(11, .bold)).foregroundColor(.v2Cream)
                .padding(.horizontal, 10).padding(.vertical, 6)
                .background(Color.v2Ink).clipShape(Capsule())
            }
            .buttonStyle(VPress())
        }
        .padding(14)
        .background(Color.v2Paper)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
    }
}

// Floating Ask-a-Local pill (Visiting mode)
struct V2AskLocalPill: View {
    var body: some View {
        Button {
            Haptic.tap(.medium)
        } label: {
            HStack(spacing: 10) {
                ZStack {
                    Circle().fill(Color.v2Amber).frame(width: 36, height: 36)
                    Image(systemName: "questionmark").font(.system(size: 14, weight: .bold))
                        .foregroundColor(.v2Cream)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Ask a verified local")
                        .font(.vRound(13, .bold)).foregroundColor(.v2Ink)
                    Text("47 online · median reply 12 min")
                        .font(.vRound(10.5, .medium)).foregroundColor(.v2Mute)
                }
                Spacer()
                Image(systemName: "arrow.up.right").font(.system(size: 12, weight: .bold))
                    .foregroundColor(.v2Mute)
            }
            .padding(10)
            .background(Color.v2Paper)
            .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.v2Amber.opacity(0.35), lineWidth: 0.8))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .buttonStyle(VPress())
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - CREWS
// ════════════════════════════════════════════════════════════════════

struct V2CrewItem: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
    let meta: String
    let members: Int
    let isPrivate: Bool
    let activeNow: Int
}

struct V2CrewsView: View {
    @State private var tab = 0
    let publicCrews: [V2CrewItem] = [
        .init(icon: "🏃", name: "Bhag Club Gurgaon", meta: "Daily 5:45 AM · Aravalli Park", members: 2_340, isPrivate: false, activeNow: 47),
        .init(icon: "💪", name: "Fitness Squad DLF", meta: "Active daily · Cyber Hub", members: 1_820, isPrivate: false, activeNow: 32),
        .init(icon: "🎵", name: "Music Collective", meta: "Weekend jams · open mic", members: 1_150, isPrivate: false, activeNow: 18),
        .init(icon: "🍕", name: "Food Explorers", meta: "Most active · 12 events/wk", members: 3_100, isPrivate: false, activeNow: 64),
        .init(icon: "📸", name: "Photo Walks GGN", meta: "Weekend walks · DLF/Sohna", members: 780, isPrivate: false, activeNow: 9),
        .init(icon: "🥊", name: "Fight Club GGN", meta: "MMA & boxing · invite", members: 620, isPrivate: false, activeNow: 5),
    ]
    let privateCrews: [V2CrewItem] = [
        .init(icon: "🎓", name: "Presidency University", meta: "4,200 students · verified", members: 4_200, isPrivate: true, activeNow: 89),
        .init(icon: "🏛️", name: "Amity University Noida", meta: "8,900 students · verified", members: 8_900, isPrivate: true, activeNow: 124),
        .init(icon: "📚", name: "BITS Pilani Gurgaon", meta: "2,100 students · verified", members: 2_100, isPrivate: true, activeNow: 41),
        .init(icon: "🏫", name: "MDI Gurgaon Alumni", meta: "Invite only · 680 members", members: 680, isPrivate: true, activeNow: 12),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    HStack(spacing: 5) {
                        Circle().fill(Color.v2Amber).frame(width: 6, height: 6)
                        Text("CRIBCREWW · CREWS").font(.vRound(10.5, .heavy)).tracking(2).foregroundColor(.v2Ink)
                    }
                    Spacer()
                    Image(systemName: "magnifyingglass").font(.system(size: 14)).foregroundColor(.v2Mute)
                        .frame(width: 32, height: 32).background(Color.v2Stone).clipShape(Circle())
                }
                .padding(.horizontal, 22).padding(.top, 14).padding(.bottom, 18)

                VStack(alignment: .leading, spacing: 6) {
                    Text("YOUR · COMMUNITIES")
                        .font(.vRound(10.5, .heavy)).tracking(1.6).foregroundColor(.v2Amber)
                    Text("Crews.")
                        .font(.vDisplay(34, .black)).tracking(-1).foregroundColor(.v2Ink)
                    Text("Where your tribe lives between meetups.")
                        .font(.vSans(13.5)).foregroundColor(.v2Mute)
                }
                .padding(.horizontal, 22).padding(.bottom, 22)

                HStack(spacing: 0) {
                    V2CrewTab(label: "Open", active: tab == 0) { tab = 0 }
                    V2CrewTab(label: "Private", active: tab == 1) { tab = 1 }
                }
                .padding(3).background(Color.v2Stone)
                .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 11, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
                .padding(.horizontal, 22).padding(.bottom, 18)

                VStack(spacing: 8) {
                    ForEach(tab == 0 ? publicCrews : privateCrews) { c in V2CrewRow(crew: c) }
                }
                .padding(.horizontal, 16)

                Spacer().frame(height: 110)
            }
        }
        .scrollIndicators(.hidden)
        .background(Color.v2Cream.ignoresSafeArea())
    }
}

struct V2CrewTab: View {
    let label: String
    let active: Bool
    let onTap: () -> Void
    var body: some View {
        Button {
            Haptic.select()
            withAnimation(.spring(response: 0.3, dampingFraction: 0.78)) { onTap() }
        } label: {
            Text(label).font(.vRound(13, .bold))
                .foregroundColor(active ? .v2Cream : .v2Mute)
                .frame(maxWidth: .infinity).padding(.vertical, 9)
                .background(active ? Color.v2Ink : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

struct V2CrewRow: View {
    let crew: V2CrewItem
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Color.v2Stone
                Text(crew.icon).font(.system(size: 22))
            }
            .frame(width: 56, height: 56)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(crew.name).font(.vRound(14.5, .bold)).foregroundColor(.v2Ink)
                    if crew.isPrivate {
                        Image(systemName: "lock.fill").font(.system(size: 9)).foregroundColor(.v2Soft)
                    }
                }
                Text(crew.meta).font(.vRound(11.5, .medium)).foregroundColor(.v2Mute)
                HStack(spacing: 5) {
                    Circle().fill(Color.v2Forest).frame(width: 5, height: 5)
                    Text("\(crew.activeNow) active now")
                        .font(.vRound(10.5, .bold)).foregroundColor(.v2Forest)
                }
                .padding(.top, 2)
            }
            Spacer()
            HStack(spacing: 4) {
                Image(systemName: "person.2.fill").font(.system(size: 9))
                Text(crew.members.formatted())
            }
            .font(.vRound(11, .semibold)).foregroundColor(.v2Coal)
            .padding(.horizontal, 9).padding(.vertical, 4)
            .background(Color.v2Stone).clipShape(Capsule())
        }
        .padding(12)
        .background(Color.v2Paper)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
    }
}

// ════════════════════════════════════════════════════════════════════
// MARK: - YOU (premium profile)
// ════════════════════════════════════════════════════════════════════

struct V2YouView: View {
    var onLogout: () -> Void
    @AppStorage("appVersion") private var appVersion: String = "v2"
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    HStack(spacing: 5) {
                        Circle().fill(Color.v2Amber).frame(width: 6, height: 6)
                        Text("CRIBCREWW · YOU").font(.vRound(10.5, .heavy)).tracking(2).foregroundColor(.v2Ink)
                    }
                    Spacer()
                    Image(systemName: "gearshape.fill").font(.system(size: 13)).foregroundColor(.v2Mute)
                        .frame(width: 32, height: 32).background(Color.v2Stone).clipShape(Circle())
                }
                .padding(.horizontal, 22).padding(.top, 14).padding(.bottom, 22)

                V2YouHero().padding(.horizontal, 16).padding(.bottom, 14)
                V2StreakHero(days: 23, target: 30).padding(.horizontal, 16).padding(.bottom, 22)

                LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                    V2YouStat(value: "12", label: "Travelers helped", icon: "hands.sparkles.fill", color: .v2Forest)
                    V2YouStat(value: "47", label: "Drops posted", icon: "camera.fill", color: .v2Amber)
                    V2YouStat(value: "142", label: "Places explored", icon: "location.fill", color: .v2Coral)
                    V2YouStat(value: "8", label: "Plans completed", icon: "checkmark.seal.fill", color: .v2Ink)
                }
                .padding(.horizontal, 16).padding(.bottom, 22)

                Text("MY · CREWS").font(.vRound(10.5, .heavy)).tracking(1.6).foregroundColor(.v2Soft)
                    .padding(.horizontal, 22).padding(.bottom, 12)
                VStack(spacing: 8) {
                    V2MyCrewMini(emoji: "🏃", name: "Bhag Club Gurgaon", meta: "Member · 14 mo")
                    V2MyCrewMini(emoji: "🎓", name: "Presidency University", meta: "Verified alumni")
                    V2MyCrewMini(emoji: "🍕", name: "Food Explorers", meta: "12 events attended")
                }
                .padding(.horizontal, 16)

                Text("VERIFIED · IN").font(.vRound(10.5, .heavy)).tracking(1.6).foregroundColor(.v2Soft)
                    .padding(.horizontal, 22).padding(.top, 22).padding(.bottom, 12)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        V2VerifyChip(icon: "checkmark.seal.fill", title: "DLF Phase 1", sub: "14 mo")
                        V2VerifyChip(icon: "checkmark.seal.fill", title: "Cyber Hub", sub: "200+ visits")
                        V2VerifyChip(icon: "graduationcap.fill", title: "Presidency", sub: "alumni")
                    }
                    .padding(.horizontal, 22)
                }

                Text("SETTINGS").font(.vRound(10.5, .heavy)).tracking(1.6).foregroundColor(.v2Soft)
                    .padding(.horizontal, 22).padding(.top, 22).padding(.bottom, 12)
                VStack(spacing: 0) {
                    V2YouSettingRow(icon: "bell.fill", label: "Notifications")
                    V2YouSettingRow(icon: "lock.fill", label: "Privacy")
                    V2YouSettingRow(icon: "location.fill", label: "Location sharing", isLast: true)
                }
                .background(Color.v2Paper)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
                .padding(.horizontal, 16)

                V2YouVersionSwitcher(appVersion: $appVersion)
                    .padding(.horizontal, 16).padding(.top, 22)

                Button {
                    Haptic.tap(.medium); onLogout()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.right.square").font(.system(size: 13, weight: .bold))
                        Text("Log Out").font(.vRound(13.5, .bold))
                    }
                    .foregroundColor(.v2Mute).frame(maxWidth: .infinity).padding(.vertical, 14)
                    .background(Color.v2Paper)
                    .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
                .buttonStyle(VPress())
                .padding(.horizontal, 16).padding(.top, 14)

                Spacer().frame(height: 120)
            }
        }
        .scrollIndicators(.hidden)
        .background(Color.v2Cream.ignoresSafeArea())
    }
}

struct V2YouHero: View {
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle().fill(Color.v2Stone).frame(width: 76, height: 76)
                    .overlay(Circle().stroke(Color.v2Hairline, lineWidth: 0.6))
                Text("🧑").font(.system(size: 30))
                Image(systemName: "checkmark.seal.fill").font(.system(size: 18))
                    .foregroundColor(.v2Amber)
                    .background(Color.v2Cream.clipShape(Circle()).padding(2))
                    .offset(x: 24, y: 24)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Devv").font(.vDisplay(22, .black)).tracking(-0.5).foregroundColor(.v2Ink)
                Text("@devv · Gurgaon").font(.vRound(12, .medium)).foregroundColor(.v2Mute)
                HStack(spacing: 5) {
                    Image(systemName: "star.fill").font(.system(size: 9))
                    Text("CITY HELPER · LVL 2").font(.vRound(10, .heavy)).tracking(1.2)
                }
                .foregroundColor(.v2Amber).padding(.top, 4)
            }
            Spacer()
        }
        .padding(20)
        .background(Color.v2Paper)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
    }
}

struct V2StreakHero: View {
    let days: Int
    let target: Int
    @State private var bounce = false
    var progress: Double { Double(days) / Double(target) }
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle().fill(Color.v2Amber.opacity(0.10)).frame(width: 64, height: 64)
                Image(systemName: "flame.fill").font(.system(size: 28))
                    .foregroundColor(.v2Amber)
                    .scaleEffect(bounce ? 1.05 : 1)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
                    bounce = true
                }
            }
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(days)").font(.vDisplay(28, .black)).tracking(-1).foregroundColor(.v2Ink)
                    Text("day streak").font(.vRound(13, .semibold)).foregroundColor(.v2Mute)
                }
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color.v2Stone).frame(height: 6)
                        Capsule().fill(Color.v2Amber).frame(width: geo.size.width * progress, height: 6)
                    }
                }
                .frame(height: 6)
                Text("\(target - days) days to City Helper Lvl 3")
                    .font(.vRound(10.5, .semibold)).foregroundColor(.v2Soft)
            }
        }
        .padding(18)
        .background(Color.v2Paper)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.v2Amber.opacity(0.18), lineWidth: 0.8))
    }
}

struct V2YouStat: View {
    let value: String
    let label: String
    let icon: String
    let color: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon).font(.system(size: 12, weight: .bold)).foregroundColor(color)
                    .frame(width: 26, height: 26).background(color.opacity(0.10)).clipShape(Circle())
                Spacer()
            }
            Text(value).font(.vDisplay(26, .black)).tracking(-0.6).foregroundColor(.v2Ink)
            Text(label).font(.vRound(11, .semibold)).foregroundColor(.v2Mute)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.v2Paper)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
    }
}

struct V2MyCrewMini: View {
    let emoji: String
    let name: String
    let meta: String
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Color.v2Stone
                Text(emoji).font(.system(size: 18))
            }
            .frame(width: 44, height: 44)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            VStack(alignment: .leading, spacing: 3) {
                Text(name).font(.vRound(13.5, .bold)).foregroundColor(.v2Ink)
                Text(meta).font(.vRound(11, .medium)).foregroundColor(.v2Mute)
            }
            Spacer()
            Image(systemName: "chevron.right").font(.system(size: 11, weight: .bold)).foregroundColor(.v2Soft)
        }
        .padding(10)
        .background(Color.v2Paper)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
    }
}

struct V2VerifyChip: View {
    let icon: String
    let title: String
    let sub: String
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon).font(.system(size: 13, weight: .bold)).foregroundColor(.v2Forest)
            VStack(alignment: .leading, spacing: 1) {
                Text(title).font(.vRound(12, .bold)).foregroundColor(.v2Ink)
                Text(sub).font(.vRound(10, .medium)).foregroundColor(.v2Mute)
            }
        }
        .padding(.horizontal, 12).padding(.vertical, 8)
        .background(Color.v2Paper)
        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(Color.v2Forest.opacity(0.25), lineWidth: 0.8))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct V2YouSettingRow: View {
    let icon: String
    let label: String
    var isLast: Bool = false
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon).font(.system(size: 13)).foregroundColor(.v2Coal)
                .frame(width: 28, height: 28).background(Color.v2Stone)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            Text(label).font(.vRound(14, .semibold)).foregroundColor(.v2Ink)
            Spacer()
            Image(systemName: "chevron.right").font(.system(size: 11, weight: .bold)).foregroundColor(.v2Soft)
        }
        .padding(.horizontal, 14).padding(.vertical, 12)
        .overlay(Rectangle().fill(isLast ? Color.clear : Color.v2Hairline).frame(height: 0.6), alignment: .bottom)
    }
}

struct V2YouVersionSwitcher: View {
    @Binding var appVersion: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("APP · VERSION").font(.vRound(10.5, .heavy)).tracking(1.6).foregroundColor(.v2Soft)
            HStack(spacing: 8) {
                vbtn("v1.0", "Apple-minimal", "v1")
                vbtn("v2.0", "Editorial · Final", "v2")
            }
            Text("Both ship in same build. Switch live.")
                .font(.vRound(10.5, .medium)).foregroundColor(.v2Soft)
        }
        .padding(14)
        .background(Color.v2Paper)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color.v2Hairline, lineWidth: 0.6))
    }
    @ViewBuilder
    func vbtn(_ label: String, _ caption: String, _ value: String) -> some View {
        Button {
            Haptic.select()
            withAnimation(.easeInOut(duration: 0.28)) { appVersion = value }
        } label: {
            VStack(spacing: 3) {
                Text(label).font(.vRound(13, .heavy))
                    .foregroundColor(appVersion == value ? .v2Cream : .v2Ink)
                Text(caption).font(.vRound(9.5, .semibold))
                    .foregroundColor(appVersion == value ? Color.v2Cream.opacity(0.7) : .v2Soft)
            }
            .frame(maxWidth: .infinity).padding(.vertical, 11)
            .background(appVersion == value ? Color.v2Ink : Color.v2Stone)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(VPress())
    }
}

#Preview {
    ContentView()
}
