## Overview
I've recently read about Erlang and it's capabilities for concurrent processing and how it's the backbone for queuing and messaging systems. I also enjoyed the assignments from my distributed systems class so I'll use this as an excuse to tap into that area and learn more about it. In this repository are some programs with descriptions for what they do, how to run them, and are in general just a book-keeping task for myself if I need to quickly reference how Erlang works.

# Scripts
1. Multinode Ping Pong (multinode_ping_pong.erl): Demonstrates message-passing between two processes. Initial steps are to register nodes for communication to the Erlang Port Mapper Daemon (EPMD), and provides cookie as an authentication mechanism so when EPMD orchestrates TCP connection between nodes, it uses cookie to initiate, then it maps out ports.
```
a. erl -sname node1 -setcookie secret
b. erl -sname node2 -setcookie secret
c. PongPid = pingpong:start_pong().
d. pingpong:start_ping(PongPid).
```

```
Opening up the command shell and starting Erlang will spawn a process with pid_a. 
pingpong:start_pong() will spawn a new process, return its PID back, pid_b (PongPid in code), then wait to receive a ping. 
pingpong:start_ping(PongPid) will then send a ping to the spawned process, when received that process will send back a pong. 
```