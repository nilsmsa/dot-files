# fzf shell integration (requires fzf >= 0.48)
# Ctrl+R  → fuzzy search bash history (replaces reverse-i-search)
# Ctrl+T  → fuzzy paste a file path onto the command line
# Alt+C   → fuzzy cd into a directory
if command -v fzf &>/dev/null; then
  eval "$(fzf --bash)"
fi
