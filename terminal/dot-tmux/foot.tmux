set -g status-position top

# 1. Base status bar: transparent background, default text
set -g status-style "bg=default,fg=default"

# 2. Inactive windows: transparent background, dimmed text (uses foot's regular8/bright black)
set -g window-status-style "bg=default,fg=colour8"

# 3. Active window: highlighted background, inverted text 
# (Uses foot's regular4/blue for bg, and regular0/black for text)
set -g window-status-current-style "bg=colour4,fg=colour0,bold"

# 4. Pane borders: match the inactive/active window colors
set -g pane-border-style "fg=colour8"
set -g pane-active-border-style "fg=colour4,bg=default"

# 5. Status left/right sections: Use foot's accent colors (green/blue)
set -g status-left-style "bg=default,fg=colour2"
set -g status-right-style "bg=default,fg=colour4"

# 6. Command line/message prompt
set -g message-style "bg=colour4,fg=colour0"

set -g status-style "bg=#1e1e2e,fg=#cdd6f4"

set -g status-left-length 150

# 1. Base status bar: transparent background, default text
set -g status-style "bg=default,fg=default"
set -g status-justify centre

# 2. Left side: [K8s Context]  [Session]  [Git]
# Colors: K8s (Cyan/colour6), Session (Blue/colour4), Git (Magenta/colour5), Separators (Dim/colour8)
set -g status-left "#[fg=colour6,bg=default] #(~/.local/bin/ctx.sh) #[fg=colour8] #[fg=colour4,bold]#S #[fg=colour8,nobold] #[fg=colour5]#(/home/nms/go/bin/gitmux #{pane_current_path}) "
set -g status-left-length 80

# 3. Window tabs: Thin separators, text-based highlighting
# 1. Force the base background to be transparent to kill the blue box
set -g window-status-style "bg=default,fg=default"
set -g window-status-current-style "bg=default,fg=default"

# 2. Window tabs (Fully flat, no background colors)
setw -g window-status-format "#[fg=colour8,bg=default] #I  #{window_name} "
setw -g window-status-current-format "#[fg=colour4,bg=default,bold] #I  #{window_name} "

# 4. Right side: Date/Time  Hostname
# Colors: Date/Time (Dim/colour8), Hostname (Blue/colour4)
set -g status-right "#[fg=colour8,bg=default]%Y-%m-%d  %H:%M #[fg=colour8] #[fg=colour4,bold]#h "
set -g status-right-length 50

# 5. Pane borders
set -g pane-border-lines heavy
set -g pane-border-style "fg=colour8"      # Inactive border
set -g pane-active-border-style "fg=colour5" # Active border (Mauve/Magenta)

# 6. Dim inactive panes (Text dims, background remains transparent default)
set -g window-style "bg=default"
set -g window-active-style "bg=default"

# 7. Message text (Command prompt)
set -g message-style "fg=colour6,bg=default,bold"
