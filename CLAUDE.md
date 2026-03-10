# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Tekrar is a French language-learning app built around daily spaced repetition.

### Core learning loop

Each day, the user learns **one new item** from one of three categories:
- **Verb** (e.g., "pouvoir", "aller")
- **Noun** (e.g., "la maison", "le chat")
- **Concept** — a grammar rule or usage pattern (e.g., COD/COI pronouns, the different uses of "plus", partitive articles)

### Daily challenge progression

The user receives **3–4 push notifications** spread throughout the day, each triggering a challenge of increasing difficulty:

1. **English → French**: Given the English word/concept, translate it to French.
2. **French → English**: Given the French word/concept, translate it to English.
3. **Free recall**: Write/use the day's item on your own (e.g., construct a sentence using the verb, use the grammar concept correctly).
4. *(Optional harder challenge depending on the item type)*

### Design principles

The app must be **well designed, aesthetically pleasing, and accessible**. UI/UX quality is a first-class priority — not an afterthought. This means clean typography, thoughtful use of whitespace, consistent visual hierarchy, smooth animations, and full accessibility support (screen readers, dynamic text sizing, sufficient contrast ratios, semantic markup).

### Completion

If the user completes the **final challenge** of the day, that day's item is marked as completed. The goal is a daily streak of completed items, reinforcing retention through repeated exposure at increasing difficulty.

## Technology Stack

| Concern | Choice |
|---|---|
| **Language** | Dart |
| **Framework** | Flutter |
| **State management** | flutter_bloc (BLoC pattern) |
| **Local database** | drift (SQLite) |
| **Notifications** | flutter_local_notifications |
| **Dependency injection** | get_it + injectable |
| **Navigation** | go_router |
| **Testing** | flutter_test (unit + widget), integration_test, bloc_test, mockito |
| **CI/CD** | GitHub Actions + subosito/flutter-action |

### Google/Apple Service Independence

The app must run on degoogled Android (e.g., GrapheneOS) without Google Play Services. **No package that requires Google Play Services, Firebase, or Apple-exclusive services may be added as a hard dependency.** Platform services (e.g., crash reporting) must be optional and gracefully degrade when unavailable. Primary Android distribution: direct APK sideloading and F-Droid.

### Project Structure (Clean Architecture)

```
lib/
├── core/           # Shared constants, theme, errors, utilities, widgets
├── features/       # Feature modules, each with data/domain/presentation layers
├── injection/      # Dependency injection setup (get_it + injectable)
├── app.dart        # Root MaterialApp widget
├── router.dart     # go_router configuration
└── main.dart       # Entry point
```

## License

GPL-3.0 — all contributions must be compatible with this license.

## Custom Agents

Three specialist agents are defined in `.claude/agents/`:

| Agent | Purpose |
|-------|---------|
| `french-expert` | French language content — grammar, vocabulary, translations, difficulty grading, educational scaffolding |
| `mobile-dev-expert` | Mobile app code — architecture, UI, state management, platform compatibility, performance |
| `testing-expert` | Tests and CI — unit/integration tests, GitHub Actions workflows, coverage, test quality |

### Mandatory agent workflow

Every code change must go through a two-phase agent process:

1. **Author phase**: Invoke the relevant agent(s) to produce the code change. For example, a new vocabulary feature should involve both `french-expert` (for content accuracy) and `mobile-dev-expert` (for implementation).
2. **Review phase**: After the change is complete, invoke a separate instance of the same agent(s) to review and sign off on the work. The reviewing instance must provide an explicit APPROVED or NEEDS CHANGES verdict.

Both phases apply to:
- Feature implementation
- Bug fixes
- Refactoring
- Planning sessions (agents should be consulted during `/plan` to inform architectural and content decisions)
