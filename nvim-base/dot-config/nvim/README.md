# Neovim Config

## Requirements

### Neovim

**Neovim nightly / 0.12+** is required. Uses the native LSP API (`vim.lsp.enable`, `vim.lsp.config`) introduced in 0.11 and nightly features.

```sh
# via bob (version manager)
bob install nightly && bob use nightly
```

### Terminal font

A **NerdFonts v3 mono** font is required for icons (diagnostic symbols, git signs, file type icons, etc.). v2 fonts will cause icons to render as invisible or garbled.

> The config uses Material Design icon codepoints (U+F0000+ range) throughout.

### System tools

| Tool | Required | Purpose |
|------|----------|---------|
| `git` | ✅ | gitsigns, diffview, lazygit |
| `ripgrep` | ✅ | grep/search — `grepprg = "rg --vimgrep"`, also used by grug-far |
| `gcc` or `clang` | ✅ | compiling Treesitter parsers |
| `tmux` | ✅ | window renaming, pane navigation (vim-tmux-navigator) |
| `curl` + `unzip` + `tar` | ✅ | Mason uses these to download/unpack LSP servers & tools |
| `node` / `npm` | ✅ | Copilot LSP backend + biome formatter |
| `lazygit` | recommended | in-editor git UI (`<leader>gg`) |
| `yazi` | optional | one picker keybind (`yazi_copy_relative_path`) — not required |

### Image preview

`snacks.image` is enabled. It uses the **Kitty graphics protocol** or **Sixel** — requires a compatible terminal (kitty, WezTerm, iTerm2, foot, etc.). Silently does nothing in unsupported terminals.

### Language runtimes (install what you need)

| Runtime | Purpose |
|---------|---------|
| `cargo` / `rustup` | Rust — rust-analyzer via Mason |
| `python3` | Python LSP/formatters via Mason |
| `java` / JDK | Kotlin LSP (`-Xmx4g` heap, auto-detected) |
| `go` | Go LSP/formatters via Mason |

---

## First-time setup

Plugins are managed via Neovim's built-in `vim.pack` (no external plugin manager needed). On first launch Neovim will download all plugins automatically.

LSP servers, formatters and linters are managed by **Mason** and installed on demand. To install everything up front:

```
:MasonInstall lua_ls bashls gradle_ls kotlin_lsp postgres_lsp
```

Treesitter parsers are auto-installed on first open of a supported file type.

---

## LSP servers (Mason)

Auto-installed via `mason.lua`:

- `lua_ls` — Lua
- `bashls` — Bash
- `gradle_ls` — Gradle
- `kotlin_lsp` — Kotlin
- `postgres_lsp` — PostgreSQL

Rust uses **rustaceanvim** which manages `rust-analyzer` separately — it is **not** installed by Mason:

```sh
rustup component add rust-analyzer
```

---

## Formatters (conform.nvim)

| Language | Formatter |
|----------|-----------|
| Lua | `stylua` |
| Go | `goimports`, `gofmt` |
| Python | `ruff_format`, `black` |
| JS/TS/JSON/CSS/HTML/MD | `biome`, `prettier` |
| TOML | `taplo` |

Install via Mason: `:Mason` → search and install, or let conform prompt on first format.

---

## Key bindings (top-level)

| Key | Action |
|-----|--------|
| `t` | Toggle buffer diagnostics panel |
| `<leader>i` | Toggle inlay hints |
| `<leader>ce` | Show line diagnostic float |
| `]d` / `[d` | Next / prev diagnostic |
| `]e` / `[e` | Next / prev error |
| `]w` / `[w` | Next / prev warning |
| `<leader>gg` | Lazygit |
| `<leader>e` | File explorer |
| `<leader><space>` | Smart file picker |
| `<leader>/` | Grep |
| `<c-/>` | Toggle terminal |
