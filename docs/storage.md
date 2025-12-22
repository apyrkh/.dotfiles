# Storage Layout

This document describes the intentional storage layout of the home directory.
The goal is clarity, safety, and long-term maintainability across multiple machines.

---

## Cloud Roles

iCloud:
- Personal documents, notes, identity, assets
- Optimized for Apple ecosystem and offline access

Google Drive:
- Financial records, shared docs, browser-first workflows
- Google Docs / Sheets as primary format

---

## Top-Level Structure (`~`)

System- and App-managed directories (Pages, Numbers, etc.) are left untouched.
User-managed content is grouped under `@`-prefixed directories:

```text
~
├── .dotfiles
├── @Archive
├── @Cloud
│   ├── iCloud        -> ~/Library/Mobile Documents/com~apple~CloudDocs
│   │   ├── @Notes
│   │   ├── @Docs
│   │   ├── @Tmp
│   │   └── @Shared
│   └── GoogleDrive   -> ~/Library/CloudStorage/GoogleDrive-*/My Drive
│       ├── __identity
│       ├── @Access
│       ├── @Archive
│       ├── @Assets
│       ├── @Docs
│       ├── @Finance
│       ├── @Library
│       └── @Tmp
├── @Media
├── @Personal
├── @Projects
├── @Tmp
└── @Vault
```

## Setup

```bash
mkdir -p ~/@Cloud
ln -sn ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/@Cloud/iCloud
ln -sn ~/Library/CloudStorage/GoogleDrive-*/My\ Drive ~/@Cloud/GoogleDrive
```
