# Automatic door script

This ComputerCraft script is designed to automatically open doors when a player with the right access level comes near.

The access levels go from 0 to ∞ where 0 is designed to let everyone in.<br>
Every user with a access level have access to all the levels below his/her own level.

For example if a player has the access level 3 they also have clearance for level 2,1 and 0\.

## Placement

In this example I'll use 3 drawbridges connected via redstone to a stone computer.<br>
I've placed a [sensor](http://ftbwiki.org/Sensor) to the left of the computer to get nearby players. ![example 1](http://puu.sh/nUOCx/079dd544c9.png)

The door script's launch parameters looks like this: ![example 2](http://puu.sh/nUOAy/c502d05ed0.png)

## Setup instructions

1. Download the script to a computercraft computer.
2. Make a startup file to launch the script every time the computer turns on.<br>
  This is an example on such a startup file

  ```
  -- Usage: door <sensor_position> <redstone_position> <accesslevel> <group> <url>
  door top right 3 group http://localhost/
  ```

  Set the name of the file to `startup` to have to start every time the computer starts.
3. Reboot the computer by typing `reboot` in the comand line or by pressing `CTRL+R`.
