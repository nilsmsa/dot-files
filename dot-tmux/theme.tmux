set -g status on
set -g status-position top
set -g status-interval 1

# -----------------------------------------------------------------------------
# TokyoNight Dark - Custom Status Bar
# -----------------------------------------------------------------------------

# General status bar style
set -g status-style "bg=#1a1b26,fg=#c0caf5"

# Left side: Session name with a background block
#set -g status-left "#[fg=#1a1b26,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#1a1b26,nobold,noitalics,nounderscore]"
#set -g status-left "#[fg=#1a1b26,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#24283b,nobold]#[fg=#c0caf5,bg=#24283b] #(/home/nms/go/bin/gitmux #{pane_current_path})#[fg=#24283b,bg=#1a1b26]"

set -g status-left-length 150

# [K8s Context] > [Session] > [Git]
set -g status-left "#[fg=#c0caf5,bg=#24283b] #(~/apps/bin/ctx.sh) #[fg=#24283b,bg=#7aa2f7,nobold]#[fg=#1a1b26,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#24283b,nobold]#[fg=#c0caf5,bg=#24283b] #(/home/nms/go/bin/gitmux #{pane_current_path})#[fg=#24283b,bg=#1a1b26]"


#set -g status-left-length 100
set -g status-justify centre

# Window tabs: Styling for active and inactive windows
setw -g window-status-format "#[fg=#1a1b26,bg=#1a1b26,nobold,noitalics,nounderscore]#[fg=#c0caf5,bg=#1a1b26] #I  #W #[fg=#1a1b26,bg=#1a1b26,nobold,noitalics,nounderscore]"
setw -g window-status-current-format "#[fg=#1a1b26,bg=#bb9af7,nobold,noitalics,nounderscore]#[fg=#1a1b26,bg=#bb9af7,bold] #I  #W #[fg=#bb9af7,bg=#1a1b26,nobold,noitalics,nounderscore]"

# Right side: Hostname and Date/Time
set -g status-right "#[fg=#565f89,bg=#1a1b26,nobold,noitalics,nounderscore]#[fg=#1a1b26,bg=#565f89] %Y-%m-%d  %H:%M #[fg=#7aa2f7,bg=#565f89,nobold,noitalics,nounderscore]#[fg=#1a1b26,bg=#7aa2f7,bold] #h "
set -g status-right-length 50

# Pane borders (matching the dark gutter/sidebar colors)
set -g pane-border-style "fg=#565f89"
set -g pane-active-border-style "fg=#7aa2f7"

# Message text
set -g message-style "fg=#7dcfff,bg=#1a1b26"

