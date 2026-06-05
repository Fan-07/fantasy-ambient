# fantasy-ambient
audio, effect and dynamic ambient to add depth to any fantasy game


|| setup guide ||

1) All three are LocalScripts. Place them all in StarterPlayerScripts. They run independently so having all three active is fine.
2) ONLY use EITHER musiccontroller OR dynamicaudio. Use MusicController for a simple looping playlist, or DynamicMusic for situation-aware switching. Pick one.
3) 9 times out of 10, use musiccontroller. what dynamicaudio does is it looks for enemy models with a part named EnemyTag within 40 studs. Add a plain Part named EnemyTag inside each enemy model and it'll work automatically. however, you can tweak it however you want to work on certain conditions

Dynamic Audio Uses ClockTime for night detection and looks for nearby enemy models for combat.

If you want UI-controlled ambient system, then there already exists a repository in my page for that purpose
