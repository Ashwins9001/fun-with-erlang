-module(multinode_ping). %define module name
-export([start_pong/0, start_ping/1, pong_loop/0]). %define function signatures as name followed by num args

start_pong() -> %define start function which will spawn the process pong_loop and return PID
    spawn(fun pong_loop/0). 

% define pong loop as process that waits for a message 
% each process has its own mailbox that queues up messages upon receipt
% receive is a reserved word that pauses this process until a pattern-matched expression of form: {ping, From} is received
% variables start with a capital letter in Erlang and atoms do not, they are self-contained
% wait for a tuple that has the reserved word ping, followed by a variable
% '!' represents the send command, left side is the process identifier (PID) to send to and right side is the message sent, in this case it sends a message back to the process it received it from and the message is the pong process's PID

% in short: wait to receive ping message from another process with pid_r, then send back pong message with current process's pid, pid_s 
pong_loop() -> 
    receive
        {ping, From} ->
            io:format("Pong received ping from ~p~n", [From]),
            From ! {pong, self()},
            pong_loop()
    end.

% call the io:format() function to output that a message is being sent 
% retrieve process's own PID from start_pong() command, then use that and send a ping of its own PID out
start_ping(PongPid) ->
    io:format("Sending ping to ~p~n", [PongPid]),
    PongPid ! {ping, self()},
    receive
        {pong, From} ->
            io:format("Received pong from ~p~n", [From])
    end.
