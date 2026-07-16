// ignore_for_file: avoid_print
import 'dart:io';

void main() async {
  print('Generating placeholder assets for Devi (Navadurga) app...');

  // 1x1 transparent PNG bytes
  final pngBytes = [
    137,
    80,
    78,
    71,
    13,
    10,
    26,
    10,
    0,
    0,
    0,
    13,
    73,
    72,
    68,
    82,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    1,
    8,
    6,
    0,
    0,
    0,
    31,
    21,
    196,
    137,
    0,
    0,
    0,
    11,
    73,
    68,
    65,
    84,
    120,
    156,
    99,
    96,
    0,
    0,
    0,
    2,
    0,
    1,
    226,
    33,
    188,
    51,
    0,
    0,
    0,
    0,
    73,
    69,
    78,
    68,
    174,
    66,
    96,
    130,
  ];

  // Minimal 1-second silent MP3 file bytes (standard MPEG-1 Layer III frame)
  final mp3Bytes = [
    0x49, 0x44, 0x33, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // ID3v2 header
    0xff,
    0xfb,
    0x10,
    0xc4,
    0x00,
    0x00,
    0x00,
    0x03,
    0x48,
    0x00, // MP3 Frame header
    0x00, 0x00, 0x00, 0x4c, 0x41, 0x4d, 0x45, 0x33, 0x2e, 0x39,
    0x38, 0x2e, 0x34, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  ];

  // Ensure directories exist
  await Directory('assets/images/durgas').create(recursive: true);
  await Directory('assets/images/ui').create(recursive: true);
  await Directory('assets/audio/mantras').create(recursive: true);
  await Directory('assets/audio/sfx').create(recursive: true);

  // Write Durga images
  final durgas = [
    'shailaputri',
    'brahmacharini',
    'chandraghanta',
    'kushmanda',
    'skandamata',
    'katyayani',
    'kalaratri',
    'mahagauri',
    'siddhidatri',
  ];

  for (int i = 0; i < durgas.length; i++) {
    final index = i + 1;
    final filename = '${index}_${durgas[i]}.png';
    final file = File('assets/images/durgas/$filename');
    await file.writeAsBytes(pngBytes);
    print('Created image: ${file.path}');
  }

  // Write UI elements
  final lotusFile = File('assets/images/ui/lotus.png');
  await lotusFile.writeAsBytes(pngBytes);
  print('Created image: ${lotusFile.path}');

  // Write Mantra audios
  for (int i = 0; i < durgas.length; i++) {
    final index = i + 1;
    final filename = '${index}_${durgas[i]}.mp3';
    final file = File('assets/audio/mantras/$filename');
    await file.writeAsBytes(mp3Bytes);
    print('Created audio: ${file.path}');
  }

  // Write SFX chime
  final chimeFile = File('assets/audio/sfx/chime.mp3');
  await chimeFile.writeAsBytes(mp3Bytes);
  print('Created audio: ${chimeFile.path}');

  print('All placeholder assets generated successfully.');
}
