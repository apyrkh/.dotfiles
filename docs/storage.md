# Storage Layout

This document defines the structure of the home directory, ensuring clarity, safety, and long-term maintainability across multiple machines.

---

## Cloud Storage

iCloud:
- Personal documents, notes, identity, assets
- Optimized for Apple ecosystem and offline access

Google Drive:
- Financial records, shared docs, browser-first workflows
- Google Docs / Sheets as primary format

---

## Directory Layout

User-managed content is grouped under `@`-prefixed directories for organizational consistency:

```text
~
├── .dotfiles
├── @Archive
├── @Cloud
│   ├── iCloud        -> ~/Library/Mobile Documents/com~apple~CloudDocs
│   │   ├── @Focus
│   │   ├── @Notes
│   │   ├── @Projects
│   │   ├── @Tmp
│   └── GoogleDrive   -> ~/Library/CloudStorage/GoogleDrive-*/My Drive
│       ├── __identity
│       ├── @Access
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

---

## Setup

```bash
mkdir -p ~/@Cloud
ln -sn ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/@Cloud/iCloud
ln -sn ~/Library/CloudStorage/GoogleDrive-*/My\ Drive ~/@Cloud/GoogleDrive
```
