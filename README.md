![version](https://img.shields.io/badge/version-21.1%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)

# HDI_4DWP_InvoicesAndBookmarks

A 4D **HDI** (How Do I) example demonstrating how **4D Write Pro bookmarks** turn a single template document into a reusable invoice layout: a developer names ranges of a template ("Main Header", "Invoice Line", "Total", etc.) with `WP NEW BOOKMARK`, and a build routine assembles a finished invoice by copying real record data into each named range. Originally published by 4D as a binary `.4DB` example for **4D v16**; converted to the modern `.4DProject` architecture so it runs on current 4D releases.

## Origin

This project started as a binary `.4DB` example database originally distributed with 4D v16 as the demo database behind the 4D Write Pro bookmarks blog post. It was converted to the modern project architecture (`.4DProject`) using 4D 21's built-in binary-to-project conversion tool, then modernised (syntax, localisation, dark mode) with the help of **GitHub Copilot**.

- **Blog post:** https://blog.4d.com/4d-write-pro-document-creation-by-programming/
- **Original download:** https://download.4d.com/Demos/4D_v16/WP_InvoicesAndBookmarks.zip

## What it demonstrates

- **`WP NEW BOOKMARK`** — naming a text range inside a 4D Write Pro template so it can be located again later, independent of subsequent edits to the surrounding document.
- **`WP GET BOOKMARKS`** — enumerating a document's current bookmarks, used both to drive the "Define bookmarks" popup menu and to validate that all mandatory bookmarks exist before an invoice can be built.
- **`WP Bookmark range`** — resolving a bookmark back into a selectable range, used to jump to a bookmark in the editor and to target where invoice data gets inserted.
- **`WP Insert document body`** — the core of `BuildInvoices`: copying the "Invoice Line" template range once per invoice line item, and the header/footer/sub-total/total ranges once per invoice, to assemble a complete document from data.
- **`WP Insert picture`** — replacing bookmarked ranges with a per-record barcode (`Invoice_BarCode`) and article icon (`Article_Icon`) picture, generated on demand by allow-listed callback methods (`SET ALLOWED METHODS`).
- **`WP EXPORT DOCUMENT`** / **`WP PRINT`** — exporting a template or a built invoice to a standalone `.4wp` file, and printing an invoice directly from the "Invoice Samples" tab.
- **`WP DELETE BOOKMARK`** — removing a bookmark definition from a template range.

## Features

The demo form (`D_Demo`) is a single window with three tabs:

- **Introduction** — a read-only 4D Write Pro tutorial document (`wpTutorial`), imported from a localised `.4wp` resource at load time.
- **Template Editor** — a list box of invoice templates (one per language/brand — e.g. "RGBplus", "JIGSAW Factory", "Alpha Tango Bookshop") backed by a 4D Write Pro area. From here you can:
  - **Define bookmarks** on the current selection via a popup menu of the eight recognised roles (Main/Secondary Header, Invoice Line, Filler, Sub-Total, Total, Main/Secondary Footer), with icons showing which are already bookmarked, missing-but-optional, or missing-and-**mandatory** (Invoice Line and Total must be bookmarked before an invoice can be built).
  - **Add**, **Duplicate**, and **Delete** templates, with record-locking checks (`Locked`/`LOCKED BY`) when a template is open elsewhere.
  - **Export**/**Import** templates to/from `.4wp` files, either the current localisation's folder or an arbitrary folder chosen with `Select folder`.
- **Invoice Samples** — a random real invoice (customer, line items, totals) is picked and rendered live through `BuildInvoices`, with a **Print** button that sends the assembled document to the printer via `WP PRINT`.

## Key commands

| Command | Used for |
|---|---|
| `WP NEW BOOKMARK` / `WP DELETE BOOKMARK` | Creating/removing a named range in a template (`DefineBookmarks.4dm`, `UpdateBookMark.4dm`) |
| `WP GET BOOKMARKS` | Listing a document's current bookmarks, to populate the definition menu and validate mandatory ones (`CheckBookmarks.4dm`) |
| `WP Bookmark range` | Resolving a bookmark name back to a selectable range, both for editing and for invoice assembly |
| `WP Insert document body` | Copying template ranges (header/line/footer/total) into the built invoice, once per data row (`BuildInvoices.4dm`) |
| `WP Insert picture` | Inserting a generated barcode/article icon into a bookmarked range (`InsertInvoicePicture.4dm`, `InsertArticlePicture.4dm`) |
| `SET ALLOWED METHODS` | Allow-listing the picture-insertion callbacks so they can be invoked from 4D Write Pro document expressions (`AllowMethods.4dm`) |
| `WP EXPORT DOCUMENT` / `WP Import document` | Round-tripping a template as a standalone `.4wp` file, per language (`Template_Export.4dm`, `Template_Import.4dm`) |
| `WP PRINT` | Printing the assembled invoice sample |

## How it works

`onStartup` seeds the `TEMPLATES`/`ARTICLES`/`CUSTOMER`/`INVOICE`/`INVOICE_LINES` tables from bundled `.4si`/`.4ie` data on first run, then calls `AllowMethods`, `InitTemplates` (importing localised template `.4wp` files if none exist yet for the current language), and `PS_Demo`. `PS_Demo` is this project's splash/entry point: called with no parameters it detects an already-open demo window and brings it to front, otherwise it hands off to the demo process via `CALL WORKER` and opens `D_Demo` with a non-blocking `DIALOG(...;*)`.

`D_Demo`'s `On Load` imports the tutorial document, selects the template named-selection (`SelectTemplates`), loads the first template into the editor, and picks a `RandomInvoice` to preview. Editing a template's bookmarks (`DefineBookmarks`) or the template list selection re-runs `CheckBookmarks`, which greys out invoice building until "Invoice Line" and "Total" are both bookmarked. `BuildInvoices` then walks the invoice's line items, inserting a copy of the "Invoice Line" range per line (via `WP Insert document body`) between the header and footer ranges, substituting totals and pictures as it goes.

## Points of interest

- **Bookmarks are template metadata, not document structure** — the same document stays a normal 4D Write Pro document; bookmarks are just named ranges layered on top, so template authors can freely rearrange headers/footers without any code changes as long as the named ranges still exist.
- **Mandatory vs. optional bookmarks** — `CheckBookmarks` treats "Invoice Line" and "Total" as required (the two ranges `BuildInvoices` cannot function without) while the rest (headers, footers, filler, sub-total) are optional, letting a minimal template still produce a valid invoice.
- **Picture insertion via allow-listed callbacks** — `InsertArticlePicture`/`InsertInvoicePicture` are registered with `SET ALLOWED METHODS` so 4D Write Pro can invoke them safely from within document processing, keeping barcode/icon generation decoupled from the template itself.
- Startup uses the modern splash pattern: window-reuse detection via `Process number`, `CALL WORKER`, and a non-blocking `DIALOG(...;*)` instead of `New process` and a blocking dialog.
- Full XLIFF localisation (English + French) covers menus, both tabs' static labels, list box headers, and every `ALERT`/`CONFIRM`/`Request` prompt in the template import/export flow.
- List box columns use `truncateMode: "none"` and `resizingMode: "legacy"`, and text/background colors adapt automatically to light/dark mode via `"automatic"`/`"automaticAlternate"`.
- All buttons are sized via `form-theme` CSS media queries (27px Liquid Glass / 23px classic) rather than a hardcoded `height`, so they stay correctly rounded under macOS Tahoe.

## Project structure

```
Project/Sources/
  Forms/D_Demo/            Single-window demo form: Introduction / Template Editor / Invoice Samples tabs
  Methods/                 PS_Demo (startup), BuildInvoices, template CRUD, bookmark helpers, sample data population
  DatabaseMethods/         onStartup.4dm — seeds sample data and imports templates on first run
  styleSheets*.css         Dark mode + Liquid Glass button sizing
Resources/
  {en,fr}.lproj/           XLIFF localisation (menus, forms, messages) and per-language invoice templates (.4wp)
  *.4si / *.4ie            Bundled sample data (Articles, Customers, Invoices, Invoice Lines, Templates)
```

## Requirements

- 4D 21.1 or later (project uses `.4DProject` architecture; `compatibilityVersion: 2101`).
- 4D Write Pro (included with 4D).

## References

- [4D Write Pro bookmarks](https://developer.4d.com/docs/WritePro/wp-bookmarks)
- [`WP NEW BOOKMARK`](https://developer.4d.com/docs/commands/wp-new-bookmark)
- [`WP GET BOOKMARKS`](https://developer.4d.com/docs/commands/wp-get-bookmarks)
- [`WP DELETE BOOKMARK`](https://developer.4d.com/docs/commands/wp-delete-bookmark)
- [`WP Bookmark range`](https://developer.4d.com/docs/commands/wp-bookmark-range)
- [`WP Insert document body`](https://developer.4d.com/docs/commands/wp-insert-document-body)
- [`WP Insert picture`](https://developer.4d.com/docs/commands/wp-insert-picture)
- [`WP EXPORT DOCUMENT`](https://developer.4d.com/docs/commands/wp-export-document)
- [`SET ALLOWED METHODS`](https://developer.4d.com/docs/commands/set-allowed-methods)
- [4D CSS stylesheets (dark mode, Liquid Glass)](https://developer.4d.com/docs/FormEditor/stylesheets)

## Screenshots
