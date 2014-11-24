Paul Dix
pcd2104@columbia.edu
COMS 4701.001 - Artificial Intelligence
Project 3 - Nine Men's Morris

There are some comments in the code, but here's some quick info about everything.
The code is all regular C++ developed in Visual Studio 2003.  If needed I can 
create a gnu makefile.

I've included a windows executable in the submission.  The program takes a time
limit, who goes first (computer or human) and what color the computer should be.
Moves are entered in the exact format listed on the web site.  They are case
sensitive so the moves must be in caps (ex: A1).  When the computer decides on
a move it starts with a search depth of 2 and increments by 2 as time permits.
It returns the move for the last full search completed.

Here are the classes in the program:
Board - holds board state
EvalSettings - holds evaluation settings (what each feature is worth)
GameNode - holds a move and a score (what bestMove returns)
Morris - the main driver program
Move - holds information about a move (coordinates and type)
Position - holds information about a position on the board
GameController - has the bestMove function, handles game state and other stuff

In addition to the regular computer vs. human game I wrote in functionality
that would allow me to run one eval function vs. another to see which would win.
It was my hope that I could use this to first write a better eval function and
later have it run for a long period of time with different eval weights for 
board features to determine what the best eval values would be.  Unfortunately,
I didn't get much time to work on the eval function and associated weights.
If you want to see one of my eval functions run against the other run:
Morris.exe t 10
The t indicates that the regular evaluate function will go first and the 10 is 
the time limit per move.  If you want the test eval function to go first just do
Morris.exe f 10
In both cases the regular eval function beats the test one.

Moves from the console are evaluated for legality.  The exception rule is handled
both in the ability to enter the move and in the generation of possible moves by
the AI.

I've also included functionality to make sure that the AI doesn't get caught in a
move loop with another program or a human.  It remembers its last move and avoids
evaluating that as a possibility in the bestMove function.

Originally I was scoring the moves by evaluating the boards they created.  I would
use this to order them to try and achieve the best ab pruning.  This ended up being
way too much extra work since generating these boards eliminated the gains of
the pruning.  In the end I decided to just order the moves by having the capture
ones come first.

I do a little bit of inadvertant pruning by limiting the number of moves generated to
50.  This really only comes into play in the endgame since before then there aren't
50 moves that can be generated.

Other than that I hope that the comments in the code help show what each part does.
Please let me know if I need to provide a gnu makefile.  I didn't write any windows
specific code so producing that shouldn't be too hard (but I'm out of time at the
moment!)

Thanks.
Paul