echo "Starting"

ffmpeg -i http://192.168.0.30:8050/video -vf format=yuv420p -f v4l2 /dev/video10
