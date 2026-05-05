# CribCreww — Product Requirements Document
**Version:** 2.0 (Research-rebuilt, two-mode architecture)
**Author:** Devv (Founder)
**Status:** Pre-Seed / MVP
**Launch City:** Gurgaon, India
**Tagline:** *Your city. Your vibe.*

---

## 0. TL;DR

CribCreww is a **friends-first, real-time, city-native interactive platform** for urban Indian Gen Z — serving both **locals** ("what's my crew doing in my city tonight") and **travelers / new migrants** ("I just landed in Gurgaon from Andhra — who can tell me where to actually go?").

**The core insight:** Static reviews are dying. AI itineraries are generic. Content-based discovery (Eater, Atlas Obscura, Time Out) is contracting. **Real-time, interactive, human-to-human local intelligence is the only thing trusted now** — Reddit r/AskNYC has 486K members, Discord travel servers grew 186% YoY (2024), TikTok wins on "right now" energy. But no one has built this *as a product*. Couchsurfing broke its trust (May 2020 paywall), Localeur died (June 2024), Showaround became a directory of ghosts, Atlas Obscura literally closed its community forums.

CribCreww is the **first interactive city OS** — not content, not feed, not map, not super-app. **People talk to real people, in real time, about a real city.** It is one focused wedge.

---

## 1. The Two User Modes

CribCreww serves two states of the same human, depending on city context:

### Mode 1 — LOCAL (you're in your home city)
*"I'm a Gurgaon resident. I want to know what's hot tonight, what my Crew is doing, and what the city is talking about."*

Primary needs: real-time city pulse, Crew chat, Gossip rooms, weekend discovery.

### Mode 2 — TRAVELER / MIGRANT (you're in a city that isn't your home)
*"I came to Gurgaon for college / work / a weekend trip. I have no friends here. I want to plan my day, find places locals actually love, and ask a real Gurgaonite a question right now."*

Primary needs: ask a verified local, see what locals are doing right now (not what tourists do), co-create day plans with a local, find hyperlocal hidden gems.

**Same app. Same five tabs. Different surfaces highlighted based on city context** (auto-detected from current location vs home-city profile setting).

This dual-mode architecture is CribCreww's structural moat. **Locals are the supply; travelers are demand.** Every feature is built so locals naturally produce signal that travelers consume — without locals having to do "extra work for tourists."

---

## 2. The Insight

### 2.1 The graveyard tells us what NOT to do
Every previous attempt at this category died for a documented reason. Pattern recognition:

| App | Killed By | Lesson |
|---|---|---|
| **Localeur** (2013–Jun 2024) | Pure-content curation never monetized. Founder pivoted to fintech. | "Locals share for free, brands sponsor city guides" doesn't scale. Need an interaction layer. |
| **Couchsurfing** | May 2020 paywall broke 2011 founder pledge ("never make you pay"). Mass exodus. | NEVER monetize the local/host side. Trust collapse is irreversible. |
| **Showaround** | Inbox broken, $25/month paywall predatory for once-a-year travelers. | Directory of inactive locals = directory of ghosts. Presence must be real-time, not static. |
| **Atlas Obscura** | Closed community forums; pulled back to editorial-only. | Pure UGC degrades without Day-1 moderation infrastructure. |
| **Yik Yak (twice)** | Anonymous + hyperlocal = predictable harassment. | Identity is mandatory. No anonymous mode, ever. |
| **Hike (India)** | Super-app sprawl. WhatsApp won on chat. | Pick one wedge. Resist payments/games/feed sprawl until v3+. |
| **BeReal** | 73.5M MAU (Aug 2022) → 16M MAU (Mar 2025). Forced-prompt novelty decayed. | Gimmicks can't sustain. Build for daily utility. |
| **TripAdvisor Forums** | Functionally dead since ~Aug 2022. Slow, anonymous, no moderation. | Async forum format lost to real-time chat. |
| **Foursquare/Swarm** | Discovery-only died. City Guide app shut Dec 2024. | "What's near me" is a feature, not a product. |
| **Withlocals** | Pivoted from free advice → paid tours. Heavy friction. | Casual "where should I get dinner?" Q&A can't be a paid transaction. |

### 2.2 The winners share five traits
Snap Map, Discord, Strava clubs, Locket Widget, Partiful, Reddit AskNYC, hyperlocal Discord servers — all built on:

1. **Identity-anchored** (real names or verified circles, never raw anonymity)
2. **Friends-first by default** (small mutuals, not public broadcast)
3. **Activity-tied** (community emerges from a real-world thing — running, party, neighborhood)
4. **No algorithmic feed** (themed rooms, ranked lists, time-decay)
5. **Privacy-default** (off by default, mutual-only)

**These five are inviolable. They are not opinions. They are the difference between live and dead apps.**

### 2.3 The market gaps that didn't exist 2 years ago
Three things shifted between 2023 and 2026 that make CribCreww newly viable:

- **Trust collapse on static reviews:** Google removed 240M+ reviews in 2024 (+40% YoY). TripAdvisor blocked 2.7M fake reviews (35% YoY rise) — including 214,000 AI-generated, growing from 4.5% (2019) to 10.7% (2024) of all flagged. The FTC fake-review rule (Oct 2024) imposes $51,744 per violation. Users no longer believe star ratings.
- **AI-itinerary fatigue:** Layla, Mindtrip, Wonderplan, ChatGPT-for-travel all produce "generic Italy itineraries copy-pasted from any travel blog" (AFAR test, 2024). 32% of US travelers will use ChatGPT to plan trips, but the #1 complaint is genericity. **AI is winning logistics; AI is losing "what's actually loved here right now."** That gap is human and local.
- **IRL revival is here:** Strava 2025: clubs 4× YoY, "Doomscrolling Is Out, Movement Is In." Run-club participation +59% globally. Bhag Club Delhi, HYROX India, Mumbai Road Runners are the real Gen Z gathering primitive. Loneliness is a measured public health crisis (US Surgeon General, 2023: 70% drop in in-person social interaction among 15–24-year-olds over 20 years).

---

## 3. The Problem — Reframed for Both User Modes

### For LOCALS:
- **Communities are real but fragmented.** Bhag Club, Cult.fit clusters, college batches, society chats — all live in WhatsApp with no discoverability, identity, events, or analytics.
- **No "what's hot tonight" signal.** Discovery happens through Instagram stories, DMs, scattered group chats. 73% of Gen Z discover events via social media (TripIt 2024).
- **No third place.** Starbucks committed $1B in Sep 2025 explicitly to chase Gen Z third-place nostalgia. The city's digital third place doesn't exist.

### For TRAVELERS / MIGRANTS:
- **No trusted source for "what locals actually love."** Google Maps reviews are AI-spam-flooded; Reddit threads go cold in 24 hours; Instagram pages are pay-for-play; TripAdvisor Forums are dead. 18% of travel-app complaints are "couldn't find the info I was looking for" (#1 pain point — Applause 2024).
- **AI itineraries are generic.** AFAR's 2024 test of Layla/Wonderplan/Mindtrip: outputs "indistinguishable from ChatGPT first-draft." 68% of Indian Gen Z would trust AI for "off-the-beaten-track" picks (Booking.com 2024) — but only if it sounds like a real local, not a tourism brochure.
- **No way to ask a verified local in real time.** Couchsurfing broke. Showaround is dead. Withlocals is paid premium tours. r/AskGurgaon has ~30K members but answers come 6–24 hours later from a handful of regulars.
- **No "locals on shift" presence layer.** Showaround listed locals; their inboxes were graveyards. Discord travel servers grew 186% YoY in 2024 specifically because they offer *real-time, geographically-anchored, presence-aware* answers — "verified street-level intelligence within seconds." No commercial product offers this.
- **Day planning is fragmented across 4–5 apps.** Wanderlog for itinerary, Google Maps for routing, TripAdvisor for ratings, Instagram for vibes, Reddit for "is X actually open?" Nothing integrates them.

### India-specific (both modes):
- ₹15.5 trillion domestic tourism spend in 2024 (5x international). Domestic trips projected from 2.5B (2024) → 5.2B (2030), CAGR 13.4% [WTTC, India Tourism Compendium 2024]. **Most travelers in India are Indians traveling within India.**
- 91% of Airbnb India guests in 2024 were domestic (vs 79% in 2019) [Skift 2025]. Domestic Indian travel is the dominant growth wave.
- Tier-2/3 → Tier-1 migration is constant: students, young professionals, IT/finance employees moving to Delhi-NCR, Bangalore, Mumbai. They arrive with no local network. **CribCreww's traveler mode is purpose-built for them.**
- MakeMyTrip, ixigo, Goibibo own bookings (flights/hotels) but explicitly NOT discovery. **There is no Indian incumbent for "what should I do tonight in Gurgaon."**

---

## 4. Target Audience

### Primary segments (in onboarding priority)

| # | Segment | Size estimate | Why first |
|---|---|---|---|
| 1 | **Gurgaon college students (18–23)** | ~80K Gen Z students across Presidency, Amity, MDI, BITS, IIT Delhi (commutable) | Pre-built network density. Verified via .edu emails. Phase-1 anchor. |
| 2 | **Gurgaon working professionals (22–28)** | ~300K NCR-based young IT/finance/startup employees | Highest disposable income. Most active going-out behavior. Crew-joining. |
| 3 | **Migrants from Tier-2/3 cities** | ~100K new arrivals/year to Gurgaon-NCR | Highest pain point: zero social network. Traveler-mode primary. |
| 4 | **Domestic weekend travelers** | Indian visitors to Gurgaon for events / family / business | Burst usage. Discovery + day-planning. |
| 5 | **International tourists in NCR** | ~5% of segment 4 | Niche initially. Becomes meaningful at v3+. |

### Anti-personas (NOT for v1)
- 30+ family-oriented users (Nextdoor demographic — wrong fit)
- Vernacular-only non-metro users (ShareChat / Moj already serve this segment well; stay focused on metro Hinglish wedge)
- Anonymous ranters (no anonymous mode at MVP — see §8)
- Pure-tourist international visitors (premature; they have Lonely Planet / Reddit / agency tours)

---

## 5. The Solution — Five Pillars (Two-Mode)

Each pillar serves BOTH locals and travelers. The UX surfaces differently based on city context.

---

### Pillar 1 — PULSE (HOME / LANDING TAB)
A live, real-time view of what is happening in your city RIGHT NOW.

**For Locals:**
- "Tonight in Gurgaon" editorial hero (the #1 spot peaking)
- Trending spots horizontal carousel (live count, label: PEAK/HIGH/MED/LOW)
- "More tonight" ranked list with intensity bars
- Pull-to-refresh updates live counts
- Tap any spot → drop into the spot's live chat (people there + people considering going)

**For Travelers (additional surface):**
- A second hero card surfaces: **"What locals love that tourists miss"** (algorithmic — high local-Crew engagement, low Google review density)
- "Right now in Gurgaon" decaying feed (24-48hr expiry): "Cyber Hub queue is dead today" / "This rooftop is packed tonight" / "New cafe opened in DLF Phase 2 today" — drops by verified locals, time-stamped, time-decayed
- "Locals on shift" pill (see Pillar 4) appears when the user is detected as out-of-city

**What's NOT on Pulse:**
- No reviews. No star ratings. No anonymous comments. No infinite scroll.
- No content for content's sake. Every element must be tappable into an interaction.

**Why this works (research):**
- Static reviews losing trust (FTC + IIT Delhi data) → real-time count is the new credibility signal
- TikTok #travel grew 250% in 2023 on real-time discovery (Bounce) → time-decay matches Gen Z expectation
- Snap Map proved aggregate live presence scales when defaulted to friends-only mutuals

---

### Pillar 2 — CREWS (was "Clubs")
*Renamed from "Clubs" — testing in progress. "Crew" feels more modern, ownership-oriented, less institutional.*

The organised community platform. Two types, identical UX, different gating.

**Public Crews** — open to all city residents:
- Bhag Club Gurgaon (run)
- Food Explorers
- DLF Cyclists
- Cyber Hub Coffee Club
- Padel India NCR

**Private Crews** — verified-only:
- Universities (verified via institutional email): Presidency, Amity, MDI, BITS, IIT Delhi alumni
- Companies (verified via work email or admin invite)
- Residential societies (verified via address proof)

**Per-crew features (MVP):**
- Live group chat
- Pinned event announcements
- Member directory (toggleable per crew)
- Crew profile (founders, mission, member count, photos)
- **NEW: "Open to traveler questions" toggle** — Crews can opt in to receiving Q&As from travelers (see Pillar 4)

**For Travelers (additional surface):**
- Browse Crews you can't join but can OBSERVE (read recent activity, see public events, attend open meetups)
- "Visiting? Drop in" — Crews can advertise open events explicitly welcoming visitors
- Find a "Crew buddy" willing to host you for one specific event

**Non-MVP (v1.1+):** Crew fundraising (Razorpay, 3-5%), Crew analytics (paid Pro), Verified badges (paid), Brand sponsorships (Nike + Run Crews; Cult.fit + Fitness Crews).

**Critical anti-pattern:** Do NOT let Crews become WhatsApp 2.0. Differentiation = discoverability + identity + structure + open events + traveler-receptivity, not "yet another group chat."

---

### Pillar 3 — GOSSIP
Live, ranked, time-decaying topic chat rooms. Topics are global news + local hot-takes. Each topic is a chat room. The headline is the entire hook.

**Examples:**
- 🏏 RCB vs CSK — The Rivalry Heats Up (24.6K joined)
- 🚇 Gurgaon Metro Phase 2 — Finally Real?
- 🏋️ Why is every gym in Cyber Hub sold out right now?
- 🎓 CUET 2025 Results Controversy

**For Travelers (additional surface):**
- "City voice" tab — Gossip rooms specifically about the city you're in
- See what people are arguing about right now in Gurgaon — proxy for "what is the local culture actually like"

**Why this works:**
- Discord 200M MAU + arXiv 2025 study identified Discord as closest digital "third place" via themed, low-pressure, non-feed rooms
- Reddit India ~74M monthly visits → topic-anchored discussion is proven
- Time-decay (24–72h) prevents the "old toxic content" graveyard
- City filter ("Gurgaon talking" vs "Globally trending") gives travelers cultural temperature

**Anti-pattern:** No anonymous posting. Yik Yak failed twice on this exact pattern.

---

### Pillar 4 — EXPLORE (THE TRAVELER-FACING TAB)
Fundamentally reframed for v2.0. **This is now the traveler's home tab when they're in a non-home city.**

#### 4.1 City directory (the static fallback)
Categories: Restaurants, Cafes, Parks, Gyms, Nightlife, Malls, Salons, Co-working, etc. **Reviews are visually subordinate.** The primary signal on every place is:

- Live count (if any people are there now)
- "X of your Crew has been here in last 30 days"
- Friends' photos from this place (last 7 days, friends-only)
- "Locals' Pick" badge (verified local has bookmarked it)
- Open / closed status

#### 4.2 NEW: "Ask a Verified Local" (free, time-boxed Q&A) — *core traveler feature*
- Type your question ("Best place for filter coffee in Gurgaon at 9pm Tuesday?")
- Pushed to verified Gurgaon locals within 2km radius who have opted into receiving questions
- Answers come in real-time chat, not async
- Free for the asker. Locals earn "City Helper" reputation points (gamified, no monetary compensation initially — Couchsurfing-paywall trap)
- 24-hour expiry on each Q

**Why this works:**
- r/AskNYC: 486K members, organic growth, real residents answering — proves voracious demand for free, fast, real-local answers (NY Groove)
- TripAdvisor Forums dying because async + slow + unverified — solved by real-time + verified
- Google Maps cannot answer "is Cyber Hub dead on Tuesday nights?" — only humans can

#### 4.3 NEW: "Locals on Shift" — presence layer — *core traveler feature*
- Map / list view of verified locals currently online and willing to chat for 5 min
- Locals toggle their availability in / out (like Uber driver "go online")
- Auto-deactivate after 15 min of inactivity (avoid Showaround's "directory of ghosts")
- Free interaction; no payment; reputation only
- Limited to 3 chats per local per session to prevent spam burnout

**Why this works:**
- Discord travel servers +186% YoY (Whop 2024) on live presence
- Showaround's failure was the directory model with no presence guarantee — fix it

#### 4.4 NEW: "Day Stitch" — co-created itinerary — *core traveler feature*
- You (traveler) drag spots into your day (Wanderlog-style time slots)
- Open it for "local input" — a verified local can drop in suggestions, swap items, add hidden gems, annotate ("don't go after 9pm, gets unsafe")
- Chat overlay alongside the day plan
- Output: a co-authored day plan with visible local-only annotations and time-stamped local edits — visibly NOT AI-generic

**Why this works:**
- Wanderlog (3.3M+ Android downloads, 4.75/5 stars) proved drag-and-drop UX
- AI planners (Layla, Mindtrip) failing on genericity — local annotation is the visible differentiation

#### 4.5 Sponsored placements (monetisation surface)
Local businesses pay for top-of-category placement, geo-targeted, badged "Sponsored." This is the v1 revenue stream.

**Critical reframe vs PRD v1.0:** Explore is NOT a Zomato competitor. Reviews de-emphasized. The center of gravity is **interactive features** — Ask a Local, Locals on Shift, Day Stitch — not content browsing.

---

### Pillar 5 — YOU (PROFILE)
Minimal, anti-Instagram identity layer.

**What's on it:**
- Avatar (verified seal if KYC'd)
- Handle, real name, **home city** (sets your default mode)
- **City Helper Reputation** (your traveler-help reputation: questions answered, day plans contributed to, verifiable badges)
- **Hyperlocal verification badges** (e.g., "Verified DLF Phase 1 Resident — 14 months", "Cyber Hub Frequent — 200+ visits") — see §8
- Crews you're in (3-up display)
- City Streak (consecutive days you opened the app + did one action)
- Places explored count
- Drops (the photos you've shared from spots, all from Pulse spot pages)

**What's NOT on it:**
- No follower count. No likes. No public feed of your posts. No biography essay.

**Why this works:**
- Locket Widget (90M lifetime installs, profitable on $12.5M raised) — identity-without-vanity is the Gen Z migration pattern
- Verified-badge research shows +37% perceived trustworthiness lift; specific authority badges (neighborhood-level) outperform generic city-level

---

## 6. The North Star — Interactive, Not Content

**Every feature decision is evaluated against this test:**

> *"Does this make people interact with real people, or does it produce content for them to consume?"*

If it's content (a list, a feed, a static page, an algorithmic recommendation), it doesn't ship without a clear interactive path attached.

This is the line that distinguishes CribCreww from:
- **Atlas Obscura** (content → editorial → forums closed)
- **Eater / Time Out** (content → contracting; Eater Cities team laid off Dec 2024)
- **Localeur** (content → no business → wound down 2024)
- **Wanderlog** (collaborative tool → traveler-only, no locals)
- **AI itinerary apps** (algorithmic → generic, AI hallucination)
- **Google Maps / Zomato** (static reviews → trust collapsed)

CribCreww is what they tried to be but couldn't: **a real-time, two-way conversation between cities and the people in them.**

---

## 7. What CribCreww Is NOT (mandatory anti-pattern list)

1. **Not anonymous.** Yik Yak died from anonymity twice. Every account is phone-verified.
2. **Not algorithmic feed.** Pulse is editorially ranked by live data; Gossip is ranked by current chat velocity; Crews are chronological.
3. **Not a super-app.** Hike's $1.4B unicorn-to-zero collapse is the cautionary tale. Resist payments / games / video / dating sprawl until v3+.
4. **Not a discovery-only app.** Highlight, Sup, Foursquare proved this dies. Every session must have a concrete reason to open today.
5. **Not a public-feed location app.** Snap Map's mutual-friends-only default is the bar.
6. **Not a Nextdoor.** No volunteer moderation. No complaint board.
7. **Not WhatsApp 2.0.** Crews differentiate via discoverability, public landing pages, identity, events, and analytics.
8. **NEW: Not a Couchsurfing.** Never monetize the local/host side. Trust collapse from breaking that contract is irreversible (May 2020 paywall → mass exodus to Trustroots/Couchers.org in 6 months).
9. **NEW: Not a Showaround.** No "directory of locals" without real-time presence. Auto-deactivate inactive locals; never show offline as available.
10. **NEW: Not an Atlas Obscura.** Build moderation, reputation, verification BEFORE scale, not after. Atlas Obscura had to close its forums because UGC quality degraded — defeating the entire interactive thesis.
11. **NEW: Not an AI itinerary tool.** Day plans must be visibly co-authored with humans — show local annotations, time-stamped local edits, local-only insertions. If output looks like ChatGPT, the interaction was wasted.

---

## 8. Trust & Safety — Day-1 Mandatory

Lifted from Snap Map + Discord patterns the research validates.

### Identity
- **Phone verification required** to post anywhere. No throwaway accounts.
- **Age-gating at signup.** Under-18s blocked entirely until v1.5. (Path's $800K FTC fine for storing minors' data is the precedent.)
- **No anonymous mode.** Ever.

### Privacy
- **Friends-only presence:** Live presence at a spot is visible (by name + face) only to mutual friends. Aggregate live counts visible to all.
- **Snap Map default:** Personal location-share OFF by default. Per-friend toggle. No public broadcast option.
- **Indian DPDP Act 2023 compliance:** explicit consent for location, data minimisation, India-resident data storage.

### Verification (the moat)
- **University verification:** institutional email + manual moderator review for first 100 students per campus.
- **Hyperlocal residence verification:** address proof OR utility bill OR 90+ days of GPS time-spent in a neighborhood = "Verified [Neighborhood] Resident" badge with time tenure visible. This is the moat. Reddit usernames have no geography. Google Maps has no resident verification. Even Localeur's "local expert" badges were city-level, not neighborhood-level.
- **City Helper reputation:** earned by answering traveler Qs, contributing to Day Stitches, hosting open Crew events. Visible on profile. Tied to specific neighborhoods.
- **Crew tenure and admin status** also visible as trust signals.

### Moderation
- **Paid moderation team from Day 1.** Not volunteers (Nextdoor anti-pattern).
- **One-tap report on every message, profile, spot.** Routes to mod team in < 4hr median response.
- **Escalation:** First report = warning. Second = 24hr suspension. Third = panel review for ban.
- **Automated red flags:** unusual messaging volume to strangers, GPS spoofing patterns, hostile language detection.

### Couchsurfing trap mitigation
- **Locals are NEVER monetized.** Helping travelers is reputational, not financial.
- Travelers are not charged for asking questions or co-creating Day Stitches.
- Monetization comes from: businesses (sponsored placements), brands (Crew sponsorships), Pro tier for Crew organisers, Razorpay fundraising fees. **Never from the local-traveler interaction itself.**

---

## 9. Distribution Strategy — Research-Backed

### Phase 0 — Founder seed (now → 50 users)
Founder personally onboards 30–50 Gen Z Gurgaon users at:
- Bhag Club run meetups (Aravalli Biodiversity Park weekend runs)
- Sector 29 Friday nights
- Cyber Hub weekend brunch crowd
- Presidency / Amity campus events
- Gurgaon migrant community spots (PG hostels in Sushant Lok, Sector 14)

QR codes at each event. Manual seeding of all 5 pillars with real data so the app feels alive on Day 1.

### Phase 1 — Anchor crews + first traveler answers (60 days → 200 DAU)
**Three anchor strategies in parallel:**

**A. Run Crew anchor.** Partner with Bhag Club Gurgaon. Their group chat moves into CribCreww. Founder commits to weekly in-person support: showing up at runs, photographing, posting recap drops. **One run crew = ~150 active members in 4–6 weeks.**

**B. University anchor.** Partner with one socially central student from Presidency or Amity. Their batch (~150–250 students) joins via invite. **One node = one batch.**

**C. NEW: Migrant-PG anchor.** Partner with 3–5 PG/co-living operators in Gurgaon (Stanza Living, Your-Space, Zolo). New residents at these PGs get an onboarding QR code. They become the first travelers/migrants asking real Qs of the locals onboarded via A and B.

Combined target: 200 sustained DAU within 60 days. **Hard gate before Phase 2.**

### Phase 2 — Density + open Pulse (Day 60 → Day 180, Gurgaon)
- Onboard 5 more Crews (mix of public + private)
- Open Pulse to organic discovery (no longer founder-curated)
- First paid local-business sponsored placements in Explore
- "Locals on Shift" feature goes live
- Hit ~1,000 DAU

### Phase 3 — Tier-1 expansion (Day 180+)
Replicate Phase 1 in Delhi (HSR/Vasant Kunj/college belt) and Bangalore (Indiranagar/Koramangala). One city at a time. Do not expand until current city hits 5,000 DAU.

### What NOT to do
- No paid digital ads in Phase 0–2.
- No celebrity influencer partnerships in Phase 0–2.
- No PR launch event before Phase-2 metrics.

---

## 10. Business Model

Five revenue streams, deployed in order:

1. **Sponsored Explore placements** — local businesses, geo-targeted. **Live from Day 90.** Estimated ₹10K–₹50K/month per category in Gurgaon initially.
2. **Brand Crew sponsorships** — Nike + Run Crews; Cult.fit + Fitness Crews; Zomato + Food Explorers. Hyper-targeted by category and city. **Live from Day 180+** once Crews have ≥500 members each.
3. **Promoted Drops & Events** — Crews/businesses pay to surface a drop on Pulse for X hours. **Live Day 180+.**
4. **CribCreww Pro** for Crew organisers — analytics, verified badge, custom branding, fundraising tools. ₹499/month. **Live Day 180+.**
5. **Razorpay-integrated Crew fundraising** — 3–5% platform fee. **Live v1.5 (~Day 270).**

**Future (v3+ only):**
- "Local Concierge" premium tier for travelers (₹299/trip — guaranteed local responses within 30 min). Held back to v3+ because monetizing the traveler side too early kills the free-utility baseline that drives word-of-mouth.

**Not in business model — ever:**
- Subscription for end-users in v1
- Charging locals to participate (Couchsurfing trap)
- Charging for asking Qs (Showaround trap)
- Ad-supported home feed
- Data sales

**Trust is the moat. Revenue cannot come at trust's expense.**

---

## 11. Tech Stack

| Layer | Recommendation | Rationale |
|---|---|---|
| Mobile | **iOS native (SwiftUI) for v1; Flutter for v2** | Already building SwiftUI. Native = faster, more polished, lower bug surface. iOS-first matches premium-device demographic. Cross-platform parity at 5,000 DAU. |
| Backend | **Supabase** (or Firebase) | Either works. Supabase: cheaper, open-source, Postgres-native (better for Crew analytics later). Firebase: better real-time chat off-the-shelf. Founder's call. |
| Real-time chat | Supabase Realtime / Firestore | Same call as backend |
| Auth | **Phone OTP only (MSG91 in India) + Sign in with Apple** | Mandatory phone verification per §8 |
| Maps | **MapKit (iOS)** for v1 | Native, free, Apple-aesthetic. Switch to Google Maps for Android. |
| Payments | Razorpay | India-first. UPI-native. |
| Push | APNs (iOS native) | iOS native for v1 |
| Analytics | **PostHog** (open source, cheaper, better funnels) + **TelemetryDeck** | PostHog: funnels + retention + session replay. TelemetryDeck: privacy-first, Apple-friendly. |
| Crash | **Sentry** | Standard. Free tier ample. |
| Image storage | Cloudinary or Supabase Storage | Cloudinary for transformations |

---

## 12. Roadmap (high-level)

| Milestone | Target | Hard Gate |
|---|---|---|
| **v1.0 (current)** | Apple-minimal UI, 5 pillars, mock data, in-app version toggle | Already shipped to simulator |
| **v1.1** | Phone OTP auth (MSG91), Supabase backend, real Crew chat, real spot chat | Backend live |
| **v1.2** | Live presence (friends-only), Pulse driven by real opt-in check-ins, basic mod tooling | 50 seed users using daily |
| **v1.3** | Crew creation flow, admin tooling, university email verification | 5 verified Crews live |
| **v1.4** | **Ask a Verified Local** feature, **Locals on Shift** presence layer, **Day Stitch** | Traveler-mode features live |
| **v1.5** | TestFlight closed beta to 100 invitees | Phase-1 anchor Crews onboarded + 5 PGs partnered |
| **v2.0 (App Store launch)** | Public launch in Gurgaon | Phase-1 = 200 DAU sustained |
| **v2.5** | Sponsored Explore placements live, first paying advertisers | 5 paying advertisers signed |
| **v3.0** | Delhi expansion + Crew analytics + Pro tier + Local Concierge premium | 5,000 Gurgaon DAU |
| **v4.0** | Bangalore + Mumbai expansion, Razorpay fundraising, Brand Crew sponsorships | 25,000 NCR DAU |
| **v5.0** | Android via Flutter, vernacular UI for Tier-2 | 100,000 NCR DAU |

---

## 13. Success Metrics

### Phase 1 (60 days)
- **DAU:** 200 sustained for 2 consecutive weeks
- **Crews:** 5 active Crews with 50+ members each
- **Messages per DAU per day:** 8+
- **Pulse spot tap-through rate:** 40%+ of DAU tap at least 1 spot
- **Traveler Qs answered within 30 min:** 70%+ (proves the local network is responsive)
- **Day Stitches with at least 1 local annotation:** 40%+ (proves co-creation works)
- **D7 retention:** 40%+
- **D30 retention:** 20%+

### Trust signals (mandatory)
- **Phone verification rate:** 100%
- **Reports per 1,000 messages:** < 5
- **Median moderation response time:** < 4 hours
- **Hyperlocal verification rate** (Phase 2+): 30% of users have at least one neighborhood badge
- **Crew chat sentiment (qualitative review):** ≥ 4.0/5

### Anti-metrics (we explicitly do NOT optimize for these)
- Time-spent-per-session (too high = unhealthy)
- Notifications sent per user
- Public-post count per user
- Follower counts (we have none)

---

## 14. Risks (concrete)

| Risk | Probability | Mitigation |
|---|---|---|
| **Cold-start failure** — first 50 users see an empty app | High | Founder personally seeds Pulse + Crews + Gossip with real data Day 1. Staged launch — only open features once supply density supports them. |
| **Crew chat = WhatsApp 2.0** | High | Differentiation: discoverability, identity, events, member directory, traveler-receptivity. |
| **"Locals on Shift" empty state** (no locals online when traveler asks) | High | Phase-1 founder-driven shifts: founder personally answers all Qs in first 60 days. Set traveler expectation: median response < 30 min, not instant. Cap question rate to maintain quality. |
| **Toxicity in Gossip rooms** | Medium | No anonymity. Phone verification. Topic auto-decay. Paid moderation. |
| **Privacy backlash** | Medium-High | Snap Map model. Location off by default. Mutual-only. India DPDP compliance. |
| **Founder burnout in Phase 0–1** | High | Phase 0–1 is 24 months of physical IRL presence. 3 events/week minimum. No remote-only mode. |
| **Cannot raise after Phase 1** | Medium | Phase-1 metrics are seed-fundable on their own. Don't burn runway on growth — burn it on community + product. |
| **Apple App Store rejection** | Low | Conform to UGC guidelines: report, block, content moderation. Submit to TestFlight 4 weeks before App Store. |
| **Locals burn out from answering Qs** | Medium | Cap Qs per local per day. Reputation system gives status reward. Move to optional paid tier (Local Concierge) only at v3+. |
| **Day Stitch outputs feel generic** | Medium | Mandatory local annotation visibility. AI + Local must be visibly distinct. Audit weekly. |
| **A new entrant copies the wedge** | Low (Year 1) → Medium (Year 2) | Moat = community density + Crew partnerships + brand relationships + hyperlocal verification database. Defensibility is local, not technical. |

---

## 15. The Vision at Scale

In five years, CribCreww is the **city-as-a-graph operating system** for urban India.

- Every metro Gen Z has CribCreww open during going-out hours of every weekend.
- Every major run club, university batch, gym tribe, hobby community in every Tier-1 metro has its home on CribCreww — not WhatsApp.
- Every Indian moving from Tier-2 to Tier-1 for college or work opens CribCreww on Day 1 in their new city to find their people.
- Every domestic Indian traveler visiting a metro asks CribCreww what locals love — and gets a real human answer in 30 minutes, not a fake review or a generic AI itinerary.
- Local advertising in Indian metros routes through CribCreww because it offers the most precisely defined audience targeting in the country (city × Crew × behaviour × neighborhood × current location × visiting status).
- The Pulse map of any Indian metro is the single most accurate real-time signal of where the city's energy is.
- CribCreww becomes a verb. *"Did you CribCreww this place yet?"*

CribCreww is not "another social app." It is the **layer of digital infrastructure on top of Indian cities themselves.**

---

## 16. Sources

Citations from May 2026 dual-research dossier underlying this PRD:

**Social / Community Pass:**
- US Surgeon General, *Our Epidemic of Loneliness* (2023): 70% drop in in-person interaction among 15–24-yos.
- Strava 12th Annual Year-in-Sport (2025): clubs nearly 4× YoY.
- FTC Consumer Reviews Rule (Oct 2024): $51,744 per violation.
- arXiv 2501.09951 (2025): Discord as digital "third place."
- TechCrunch (Nov 2025): Locket Widget — 90M lifetime installs, profitable.
- CNBC (Apr 2025): Partiful — 500K MAU Q1 2025, +400% YoY.
- Inc42 (2025): Zomato Project Fairplay.
- Business Upturn (2025): India run club revolution; HYROX India 2025–26.
- Snap Help / Snap Values: Snap Map friends-only default.

**Traveler / Discovery Pass:**
- TripIt Setjetting Report (2024): 40.5% of Gen Z use TikTok for travel planning.
- CNBC (May 2025): TripAdvisor blocked 2.7M fake reviews in 2024 (35% YoY rise).
- Originality.AI: AI-generated TripAdvisor reviews grew 4.5% (2019) → 10.7% (2024).
- Google Maps Transparency Report (2024): 240M+ reviews removed.
- Airbnb News (2024): 70% of Airbnb guests cite "authentic local experience"; 1 in 5 explicitly chose Airbnb to "travel like a local."
- Skift (Sep 2025): 91% of Airbnb India guests are domestic in 2024 (vs 79% in 2019).
- WTTC + India Tourism Compendium (2024): Domestic travel ₹15.5T spend; 2.5B → 5.2B trips by 2030 (CAGR 13.4%).
- Crunchbase / LinkedIn: Localeur wound down June 2024.
- Inverse + Couchers.org: Couchsurfing May 2020 paywall collapse.
- Trustpilot: Showaround inbox issues, $25/month paywall.
- Atlas Obscura forums page: forums closed.
- Nasdaq: Atlas Obscura — 6.5M MAU, $20M revenue, profitable.
- AppBrain: Wanderlog — 3.3M+ Android downloads, 4.75/5.
- Layla, Mindtrip, AFAR (2024): AI itinerary apps fail on genericity.
- Statista (2025): Social platforms beat AI tools for travel inspiration.
- Mindful Ecotourism / Travala (2025): 32% of US travelers will use ChatGPT to plan trips.
- Booking.com (2024): 68% of Indian Gen Z trust AI for off-the-beaten-track picks.
- Whop (2024): Discord travel servers +186% YoY.
- NY Groove + SubredditStats: r/AskNYC — 486K members, real-resident answers.
- User Intuition: Verified-badge research → +37% perceived trustworthiness lift.
- Axios Detroit (Dec 2024): Vox Media laid off Eater Cities team.
- CNBC (Mar 2025): Dating apps pivoting to in-person events as Gen Z loneliness persists.
- Bounce 2024 TikTok Travel Index: #travel posts +250% in 2023.

[Full URL list in research dossiers — saved separately if needed.]

---

**End of PRD v2.0 (Two-Mode Architecture).**
