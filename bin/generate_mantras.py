import json
import asyncio
import urllib.request
import os
import sys

async def main():
    try:
        import edge_tts
    except ImportError:
        print("Error: edge-tts package is not installed in this environment.")
        sys.exit(1)

    print("Generating 9 Navadurga mantras...")
    json_path = 'assets/data/navadurga_data.json'
    if not os.path.exists(json_path):
        print(f"Error: JSON file not found at {json_path}")
        sys.exit(1)
        
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    # Ensure audio directories exist
    os.makedirs('assets/audio/mantras', exist_ok=True)
    os.makedirs('assets/audio/sfx', exist_ok=True)

    for item in data:
        if item['id'] != 3:
            continue
        name = item['nameEnglish'].lower()
        mantra = item['mantraMalayalam']
        audio_path = f"assets/audio/mantras/{item['id']}_{name}.mp3"
        print(f"Generating audio for {item['nameEnglish']}...")
        
        # Use female Malayalam voice ml-IN-SobhanaNeural for correct Sanskrit pronunciation via Malayalam script mapping and slow down the rate by 20%
        communicate = edge_tts.Communicate(mantra, "ml-IN-SobhanaNeural", rate="-20%")
        await communicate.save(audio_path)
        print(f"Saved {audio_path} (size: {os.path.getsize(audio_path)} bytes)")

    print("Skipping temple bell chime download as only Chandraghanta is targeted...")
    print("Audio generation completed successfully.")

if __name__ == "__main__":
    asyncio.run(main())
