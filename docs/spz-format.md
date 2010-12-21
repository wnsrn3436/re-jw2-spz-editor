# SPZ file format

Analysis of Jurassic Primitive War 2's unit image file (SPZ).

## Header, 32 bytes

Every value is a 4 byte little endian integer.

| Offset | Field |
|---|---|
| `0x00` | Width in pixels |
| `0x04` | Height in pixels |
| `0x08` | Center x |
| `0x0C` | Center y |
| `0x10` | Collision point x |
| `0x14` | Collision point y |
| `0x18` | Data size excluding the header |
| `0x1C` | Unknown |

The center and collision points are stored as negative values.

## Pixel data

Starts at `0x20` and runs one row at a time. A row begins with the encoded length of that row as 2 bytes, then the pixels follow. This editor writes only the low byte of those 2 and skips them when reading. A pixel is one byte of palette index, and index 0 means transparent, followed by a run length as one byte. For example `00 0B` means eleven transparent pixels in a row. A unit sprite is mostly transparent, so this single rule already cuts the size down a lot.

## PNT palette

Slot 0 is the transparent color and slot 1 is the shadow color. From `0x3D4`, ten player colors follow at 4 byte intervals. Each entry is 4 bytes of R, G, B, 0.
