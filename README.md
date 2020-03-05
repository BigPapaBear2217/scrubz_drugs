```
-------------------------- Scrubz Drugs ---------------------------
-- //Credit to flawws and his script. -> https://github.com/FlawwsX/np_selltonpc
-- //I used his draw text and may have thiefed a thing or two. <3
-- //Also Credit to whoever made the enumeratepeds.
-- //Also all hail my code god homie who answeres all my questions.
-- //Hail!
-------------------------------------------------------------------
```

This script was meant to be an all in one drug script when it comes to handling drugs. This is meant for teleports to drug production/conversion locations, and selling to locals (npc's). Since I have a seperate way to obtain items and such, I haven't included the ability to obtain any drug materials or the actual drugs themselves in the public release. I only included the cocaine conversion since everyone does everything differently when it comes to producing drugs. Cocaine is done as an example to expand from. Teleport locations are saved serverside. :)

I may expand on this further if there is enough interest in me doing.

**Note**
Some of the code may be a bit janky, and not written the best since I'm a pepega and have only been coding in lua for a couple weeks
now. Please be nice to me. ^_^ If anything can be written better or is wrong, just post/submit a pull request please and thank you.

------ Bugs ------  
I already know you are able to sell to the locals inside various shops around the city (IE shop clerks). I'm just lazy and haven't gone to each one to grab coords and add checks to disable being able to sell drugs in the stores.

----------------------------------------------------

To change the enter vectors, edit the following inside "core/server/sv_locations.lua"

```
local weedEnter = vector3(-99.91, -1783.16, 28.29)
local cocaineEnter = vector3(-85.98, -1794.88, 27.66)
local methEnter = vector3(-93.73, -1788.34, 28.09)
```

----------------------------------------------------

I left a cocaine example in to deal with producing drugs at the locations. I am not including anthing else since everyone has different
items and requires differnt amounts of things to do stuff. But I did lay the groundwork to have other drugs working. All you need to do
is fill in the bits I left blank since the triggers are already there in a few spots like cocaine is.

----------------------------------------------------
