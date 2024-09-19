from re import sub
import subprocess
import wave
import os

# DEPENDENCIES:
# - alsa-utils

def notify(body, summary, app_name, tone=False, file="/home/basti/.config/skxxtz/audio/notification.wav"):
    subprocess.run(["notify-send", "-u", "low", "-t", "0", body, summary, "--app-name", app_name])
    if tone:
        wf = wave.open(file, 'rb')
        channels = wf.getnchannels()
        sample_width = wf.getsampwidth()
        frame_rate = wf.getframerate()
        command = ['aplay', '-r', str(frame_rate), '-f', f'S{sample_width * 8}', '-c', str(channels), '-q', file]
        wf.close()
        os.system(' '.join(command))
