# Minecraft Who

A CLI program to quickly print the list of players on a minecraft server.


## Usage

```
Usage:
  mcwho [flags...] [arg...]

Minecraft Who

Flags:
  --help                       # Displays help for the current command.
  --host, -h (required)        # The Minecraft server IP, not a DNS name
  --password, -r (required)    # The RCON password
  --port, -p (default: 25575)  # The Minecraft RCON port, not the game port
```

This will output something like:
```
[0/10] <nobody>
```
If no one is on the server.


Or, it will print
```
[3/10] Player1|Player2|Player3
```
If people are playing.


## TODO

- json output