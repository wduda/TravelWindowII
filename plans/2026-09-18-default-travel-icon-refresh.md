# Default travel button icon refresh

## Branch

`main`

## Goal

Replace the default Travel Window II travel button artwork with the new signpost-and-dwarf-rune icon while preserving the existing size variants and all button behavior.

## Plan

1. Replace the default travel button resources at 32x32, 48x48, and 64x64.
2. Keep filenames unchanged so no Lua code or settings mappings need to change.
3. Leave the Boots, Backpack, and Horse alternate icon styles untouched.
4. Verify the three default resource paths remain present in `src/resources/`.

## Expected result

The `Default` travel button style uses the new signpost-and-dwarf-rune artwork at all supported button sizes.
