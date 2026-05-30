# tmux cheat sheet
## Sessions
Start a new session with the name *mysession*
```
tmux new -s mysession
```

kill/delete session *mysession*
```
tmux kill-session -t mysession
```

kill/delete all sessions except the current session
```
tmux kill-session -a
```

kill/delete all sessions except *mysession*
```
tmux kill-session -a -t mysession
```

help screen
```
CTRL+b ?
```

rename session
```
CTRL+b $
```

detatch from session
```
CTRL+b d
```

show all sessions
```
tmux ls
```

attach to last session
```
tmux a
tmux at
tmux attach
tmux attach-session
```

attach to a session named *mysession*
```
tmux -a -t mysession
tmux attach-session -t mysession
```

change to previous session
```
CTRL+b (
```

change to next session
```
CTRL+b )
```

## Windows
start a new session with the name *mysession* and window *mywindow*
```
tmux new -s mysession -n mywindow
```

create window
```
CTRL+b c
```

rename current window
```
CTRL+b ,
```

close current window
```
CTRL+b &
```

previous window
```
CTRL+b p
```

next window
```
CTRL+b n
```

switch/select window by number
```
CTRL+b 0 ... 9
```

reorder window, swap number 2 (src) and 1 (dst)
```
swap-window -s 2 -t 1
```

move current window to the left by one position
```
swap-window -t -1
```

## Panes
toggle last active pane
```
CTRL+b ;
```

split pane vertically
```
CTRL+b %
```

split pane horizontally
```
CTRL+b "
```

move the current pane left
```
CTRL+b {
```

move the current pane right
```
CTRL+b }
```

toggle synchronize-panes (send commands to all panes)
```
setw synchronize-panes
```

toggle between pane layouts
```
CTRL+b SPACEBAR
```

switch to next pane
```
CTRL+b o
```

show pane numbers
```
CTRL+b q
```

switch/select pane by number
```
CTRL+b q 0 ... 9
```

toggle pane zoom
```
CTRL+b z
```

convert pane into a window
```
CTRL+b !
```

close current pane
```
CTRL+b x
```

## Copy Mode
use vi keys in buffer
```
setw -g mode-keys vi
```

enter copy mode
```
CTRL+b [
```

scroll the buffer
```
CTRL+b [
    then use the arrow keys to move or PGUP/PGDOWN
```

enter copy mode and scroll one page up
```
CTRL+b PGUP
```

quit mode
```
q
```

go to top line
```
g
```

go to last line
```
G
```

move cursor left
```
h
```

move cursor down
```
j
```

move cursor up
```
k
```

move cursor right
```
l
```

move cursor forward by word
```
w
```

move cursor backword by word
```
b
```

search forward
```
/
```

search backward
```
?
```

next keyword occurrence
```
n
```

previous keyword occurrence
```
N
```

start selection
```
SPACEBAR
```

clear selection
```
ESC
```

copy selection
```
ENTER
```

paste contents of buffer_0
```
CTRL+b ]
```

display buffer_0 contents
```
show-buffer
```

copy entire visible contents of pane to buffer
```
capture-pane
```

show all buffers
```
list-buffers
```

show all buffers and paste selected
```
choose-buffer
```

save buffer contents to *buf.txt*
```
save-buffer buf.txt
```

delete buffer_1
```
delete-buffer -b 1
```

## Miscellaneous
enter command mode
```
CTRL+b :
```

set OPTION for all sessions
```
set -g OPTION
```

set OPTION for all windows
```
setw -g OPTION
```

show every session, window, pane
```
tmux info
```

show shortcuts
```
CTRL+b ?
```
