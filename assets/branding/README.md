# Hoovi Music frontend branding

This folder contains frontend-facing Hoovi Music brand assets.

## Assets

- `hoovi-music-logo.svg` — square app/logo mark.
- `hoovi-music-wordmark.svg` — wide logo lockup for splash, about, docs, and web surfaces.

## Usage

Use the logo where the app needs a compact mark:

- splash screen
- about page
- sidebar header
- login/import welcome screen
- empty states

Use the wordmark where there is enough horizontal room:

- docs
- landing pages
- about screen
- release notes

## Color rules

```txt
background: #08050E
surface:    #140C22
primary:    #7C3AED
accent:     #B989FF
text:       #F8F5FF
muted:      #CDB7FF
```

## Current branding status

The web manifest and brand assets have been updated. Native generated PNG icons still need a proper icon generation pass so Flutter platform folders stay consistent.

Do not manually edit generated Flutter asset files unless running the generator afterwards.
