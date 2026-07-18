import json
import asyncio
import os
import sys
import subprocess

async def main():
    try:
        import edge_tts
    except ImportError:
        print("Error: edge-tts package is not installed in this environment.")
        sys.exit(1)

    try:
        import imageio_ffmpeg
    except ImportError:
        print("Error: imageio-ffmpeg package is not installed in this environment.")
        sys.exit(1)

    print("Generating Navadurga Kalaratri mantra...")
    json_path = 'assets/data/navadurga_data.json'
    if not os.path.exists(json_path):
        print(f"Error: JSON file not found at {json_path}")
        sys.exit(1)
        
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    # Ensure audio directories exist
    os.makedirs('assets/audio/mantras', exist_ok=True)

    for item in data:
        if item['id'] != 7:
            continue
        name = item['nameEnglish'].lower()
        mantra = item['mantraMalayalam']
        audio_path = f"assets/audio/mantras/{item['id']}_{name}.mp3"
        temp_audio_path = f"assets/audio/mantras/{item['id']}_{name}_temp.mp3"
        print(f"Generating audio for {item['nameEnglish']}...")
        
        # Use female Malayalam voice ml-IN-SobhanaNeural for correct Sanskrit pronunciation via Malayalam script mapping
        # Slow down rate by 20% and double the volume (+100%)
        communicate = edge_tts.Communicate(mantra, "ml-IN-SobhanaNeural", rate="-20%", volume="+100%")
        await communicate.save(temp_audio_path)
        print(f"Saved temporary audio {temp_audio_path} (size: {os.path.getsize(temp_audio_path)} bytes)")

        # Now transcode using imageio_ffmpeg to 160 kbps, 44100 Hz
        ffmpeg_exe = imageio_ffmpeg.get_ffmpeg_exe()
        print(f"Transcoding using local ffmpeg: {ffmpeg_exe}...")
        
        cmd = [
            ffmpeg_exe,
            '-y',
            '-i', temp_audio_path,
            '-b:a', '160k',
            '-ar', '44100',
            audio_path
        ]
        
        # Run ffmpeg command
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if result.returncode != 0:
            print("Error: ffmpeg transcoding failed!")
            print(result.stderr.decode('utf-8'))
            sys.exit(1)
            
        # Clean up temp file
        if os.path.exists(temp_audio_path):
            os.remove(temp_audio_path)
            
        print(f"Saved final transcoded audio to {audio_path} (size: {os.path.getsize(audio_path)} bytes)")

    print("Audio generation completed successfully.")

if __name__ == "__main__":
    asyncio.run(main())
