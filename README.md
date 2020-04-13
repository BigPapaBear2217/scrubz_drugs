```
-------------------------- Scrubz Drugs v2 ------------------------
-- //Credit to flawws and his script. --> https://github.com/FlawwsX/np_selltonpc
-- //I used his draw text and may have thiefed a thing or two. <3
-- //Credit to whoever made the enumeratepeds.
-- //Thanks Trundle for the useful thread info!!
-- //Credit of course goes to my code god homie who puts up with all my lua questions.
-- //Credit to the author of esx_pickweed --> https://github.com/TayUE4/esx_pickweed
-- //Big thanks to Pulga#7662 for some additions to the script and for helping with testing. 
-- //Thanks to Zentrox#0650 for testing.
-------------------------------------------------------------------
```

**Note**  
I have rewritten some of the code. Hopefully it shouldn't be super heavy for clients. I have attempted to get it to run as close to 0.01ms as possible. I'm still a pepega, so if something can be written better/something is written wrong/you can optimize it better, please do so and make a pull request or just shoot me a message on discord: Scrubz#0001

---------------------------------------------------

**Information**  
-- You will need to disable the default teleports in esx_ambulancejob.  
-- Either change all the items used in this script to suit your needs, or upload the sql provided.  
-- I'm not 100% sure what ipl's are loaded by default, but if you fall into the ground when you teleport, go grab fivem-ipl --> https://github.com/ESX-PUBLIC/fivem-ipl  
-- You can change all the locations inside core/server/sv_locations.lua  
-- Default Door Locations (Located across from the Grove St gas station)  
(Ignore the restricted area. I didn't restart the script before I took the pic. Just tp'ed to the location. That won't be displayed in that location in the pic.) 
![alt text](https://i.imgur.com/4hpLJLR.png "Default Drug Door Locations")

---------------------------------------------------  

------ Bugs ------  
I already know you are able to sell to the locals inside various shops around the city. I'm just lazy and haven't gone to each one to grab coords and add checks to disable being able to sell drugs in the stores.

--//Still too lazy to fix this^^ LOL. I may eventually add a table that you can add locations to in order to disable selling inside//--

---------------------------------------------------

