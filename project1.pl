:- use_module(library(lists)).

start:- initBoard(Board), displayGame(Board).
vsep :- write('|').
hsep :- write('+---+---+---+---+ +---+---+---+---+'), nl.

/* initialize board as a 2x2 matrix of boards */
initBoard(Board) :-
    append([[
            [
                [[2,2,2,2], [0,0,0,0], [0,0,0,0], [1,1,1,1]], 
                [[2,2,2,2], [0,0,0,0], [0,0,0,0], [1,1,1,1]]
            ],
            [
                [[2,2,2,2], [0,0,0,0], [0,0,0,0], [1,1,1,1]], 
                [[2,2,2,2], [0,0,0,0], [0,0,0,0], [1,1,1,1]]
            ]
           ]], Board).

/* print player number */
printPlayer(N) :-
    write('Player '),
    write(N),
    nl.

printSep(2) :- vsep.
printSep(_).

/* translation for values in the internal data structure which will be displayed in displayGame */
translate(0, ' ').
translate(1, 'X').
translate(2, 'O').

/* print a single cell with a vertical separator */
printCell(C) :-
    translate(C,P),
    vsep,
    write(' '),
    write(P),
    write(' ').

/* print a line of a single board */
printLine([]).
printLine([C|L]):-
    printCell(C),
    printLine(L).

/* print a line to the screen, this line contains the Nth line of the top or bottom boards */ 
printBoardLine([], 0) :- nl.
printBoardLine([Line|Lines], N) :-
    N > 0,
    N1 is N - 1,
    printLine(Line),
    vsep,
    write(' '),
    printBoardLine(Lines, N1).

/* print boards after transposing */
printTransposed([], 0).
printTransposed([Current|Next], N) :-
    N > 0,
    N1 is N - 1,
    printHSep(N),
    printBoardLine(Current, 2),
    printTransposed(Next, N1).


/* print top and bottom boards */
printBoards([], 3).
printBoards([Top|Bottom], N) :-
    N1 is N + 1,
    nl, printPlayer(N),
    hsep,
    transpose(Top, Transposed),
    printTransposed(Transposed, 4),
    hsep, nl,
    printBoards(Bottom, N1).

/* print the 4 boards as a 2x2 matrix */
displayGame(Board) :-
    printBoards(Board, 1).
