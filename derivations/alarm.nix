{pkgs}:
pkgs.writeShellScriptBin "alarm" ''
  set -e
  echo "mpv ~/downloads/alarm.mp3" | at $1
''
