# Security rules — SreerajP_Devi

Read this file before changing any security-sensitive code (assets loading, configurations, permissions). These rules are part of the project rules in [../.agents/AGENTS.md](../.agents/AGENTS.md). Full detail is in the Security Architecture section of [architecture.md](architecture.md).

Security is not optional. Follow these for every change.

- **Offline-Only Boundaries**: The app must not initiate or allow network calls. All contents, images, and audio assets must reside locally in the application bundle.
- **Minimal Permissions Principle**: Do not request storage access permissions (`READ_EXTERNAL_STORAGE` / `WRITE_EXTERNAL_STORAGE`), camera, location, or network access permissions. The app only requires permission to play audio.
- **Input Validation for AppConfig**: Validate fields loaded from `assets/config/app_config.json` dynamically and ensure they do not cause exceptions. Fall back gracefully to `AppConfig.fallback` on any mismatch or parse failure.
- **Safe Resource Management**: Ensure that audio resources, controllers, and tickers are disposed of correctly to prevent memory leaks and thread crashes.
- **Never Log Secrets**: Even though the app deals with public devotional content, ensure that debug log strings do not print personal user information or developer credentials. Keep error messages user-safe.
- Read the shared security blueprint template at [guidelines/security.md](guidelines/security.md) when touching security-sensitive code.
