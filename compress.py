import imageio_ffmpeg
import subprocess

ffmpeg_path = imageio_ffmpeg.get_ffmpeg_exe()
input_path = "assets/video/video.mp4"
output_path = "assets/video/video_small.mp4"

cmd = [
    ffmpeg_path,
    "-y",
    "-i", input_path,
    "-vf", "scale=-2:480",
    "-vcodec", "libx264",
    "-crf", "28",
    "-preset", "fast",
    "-an",
    output_path
]

print(f"Running FFmpeg using {ffmpeg_path}...")
subprocess.run(cmd, check=True)
print("Compression done!")
