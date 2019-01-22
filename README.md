
## Build the image
- `docker build -t mpvosseller/ubuntu-browsers .`

## Start the browser

- Chrome
	- `docker run -p 5900:5900 --shm-size=1g mpvosseller/ubuntu-browsers`

- Firefox
	- `docker run -p 5900:5900 --shm-size=1g -e BROWSER=firefox mpvosseller/ubuntu-browsers`

- View from macOS with VNC
	- `open -a "Screen Sharing" vnc://:1234@localhost`


## Troubleshooting
- If your VNC client freezes try killing your VNC client and reconnecting.
- If the container's VNC server crashes try relaunching with:
	- `docker exec <container-id> x11vnc -forever -passwd 1234`
- Keep in mind that the container won't exit if you simply close your VNC client. You must kill the browser process or manually stop the container with:
	- `docker stop <container-id>` 


## Alternative setup
As an alternative setup you can run an Xserver on macOS and have the browser display directly to it. This is a neat setup but I don't recommend it as it appears much slower and much buggier.

### One time setup
- `brew install socat`
- `brew cask install xquartz`
  - You may need to run XQuartz manually once
  		- `open -a XQuartz`
  - You may also need to log out and log back in once

### Start socat
- `socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"`

### Run Chrome
- `docker run -e DISPLAY=$(ipconfig getifaddr en0):0 --shm-size=1g mpvosseller/ubuntu-browsers google-chrome --no-sandbox --disable-gpu`

### Run Firefox
- `docker run -e DISPLAY=$(ipconfig getifaddr en0):0 --shm-size=1g mpvosseller/ubuntu-browsers firefox`

