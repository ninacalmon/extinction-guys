# Extinction Guys

*Itch.io link: <https://morgothe.itch.io/prototype-extinction-guys>*

[![Godot](https://img.shields.io/badge/Godot-4.7-478cbf)](https://godotengine.org)
[![Language](https://img.shields.io/badge/Language-GDScript-blueviolet)](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html)
[![License](https://img.shields.io/badge/License-All%20Rights%20Reserved-critical)](#license)


Extinction Guys is a 2D ecosystem in which three small species share a patch of land. They feed, drink, hunt and procreate. The balance of their ecosystem is fragile and it's your goal to try and keep it steady.

This project was made to study clean code and game code architecture best practices.

## Table of contents

- [Requirements](#requirements)
- [Project structure](#project-structure)
- [License](#license)
- [Credits](#credits)

## Requirements

Godot 4.7 with the Forward Plus renderer. Older engine versions will not open the project.

## Project structure

```
res://
├── resources/       # fonts, shaders, shared resources
├── scenes/          # creatures, UI, and the main scene
│   ├── UI/          # HUD screens and overlays
│   ├── mimo/        # mimo scenes
│   ├── peepo/       # peebo scenes
│   └── wungus/      # wungus scenes
├── scripts/         # logic split by creature and feature
│   ├── actions/     # shared creature actions
│   ├── creatures/   # per-species logic
│   ├── game_effects/ # intervention effects
│   ├── map/         # world generation
│   └── ui/          # interface scripts
├── sprites/         # art assets and tilemaps
└── *.gd             # autoload singletons and globals
```

## License

All rights reserved. No open source license applies to this project. Permission to use, modify, or redistribute the code and assets is not granted.

## Credits

Extinction Guys is made by Nina. Press Start 2P font by CodeMan38.
