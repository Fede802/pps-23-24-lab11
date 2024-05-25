%utils
range(L,H,L).
range(L,H,O) :- NL is L + 1, NL < H, range(NL, H, O).

%-----------------------------------------------------------------------------------------Ex 1-----------------------------------------------------------------------------------------
%Ex 1.1
%search2(Elem, List)
%Examples:
%search2(a, [c,a,a,d,a,a]). -> yes, two solution
%search2(a, [c,a,a,a]). -> yes, two solution
%search2(a, [c,a,a,b]). -> yes
%search2(a, L). -> yes, infinite solution
%search2(a, [_,a,_a,_]). -> yes, three solution
search2(E, [E,E|T]).
search2(E, [H|T]) :- search2(E, T).

%Ex 1.2
%search_two(Elem, List)
%Examples:
%search_two(a, [b,c,a,a,d,e]). -> no
%search_two(a, [b,c,a,d,a,d,e]). -> yes
search_two(E, [E,_,E|T]).
search_two(E, [H|T]) :- search_two(E, T).

%Ex 1.3
%size(List, Size)
%Examples:
%size([b,c,a,d,a,d,e], 7). -> yes
%size(X,Y). -> fully relational
size([], 0).
size([H|T], S) :- size(T, TS), S is TS + 1.

%Ex 1.4 
%sum(List, Sum)
%Examples:
%sum([1,2,3], X). -> yes, X/6
sum([], 0).
sum([H|T], S) :- sum(T, TS), S is TS + H.

%Ex 1.5
%max_min(List, Max, Min)
%Examples:
%max_min([3, 1, 5], X, Y). -> yes, X/5 Y/1
max_min([], Max, Max, Min, Min).
max_min([H|T], TMax, Max, TMin, Min) :- H >= TMax, max_min(T, H, Max, TMin, Min).
max_min([H|T], TMax, Max, TMin, Min) :- H =< TMin, max_min(T, TMax, Max, H, Min).
max_min([H|T], Max, Min) :- max_min(T, H, Max, H, Min), !.
%max_min2([3, 1, 5], X, Y). -> yes, X/5 Y/1
max_min2([H], H, H).
max_min2([H|T], H, Min) :- max_min2(T, Max, Min), H >= Max, !.
max_min2([H|T], Max, H) :- max_min2(T, Max, Min), H =< Min, !.
max_min2([H|T], Max, Min) :- max_min2(T, Max, Min).

%Ex 1.6
%split(List1, Elements, SubList1, SubList2)
%Examples:
%split ([10 ,20 ,30 ,40 ,50] ,2 ,L1 ,L2)
split(L, 0, [], L).
split([H|T], N, [H|T2], T3) :- NN is N - 1, split(T, NN, T2, T3), !.

%Ex 1.7
%rotate(List, RotatedList)
%Examples:
%rotate([10 ,20 ,30 ,40], L).
rotate([H,L], RL) :- append(L, [H], RL).

%Ex 1.8
%dice(X)
%Examples:
%dice(X). -> yes, X/1; X/2; ... X/6
dice(X) :- member(X, [1,2,3,4,5,6]).
dice2(X) :- range(1,7,X).

%Ex 1.9
%three_dice (TotalFaceSum, FacesResultList).
%Examples:
%three_dice (5 , L). -> yes, L/[1 ,1 ,3]; L/[1 ,2 ,2];...;L/[3 ,1 ,1]
three_dice(S, [X,Y,Z]) :- dice(X), dice(Y), dice(Z), S is X + Y + Z.

%-----------------------------------------------------------------------------------------Ex 2-----------------------------------------------------------------------------------------
drop_any(X, [X|T], T).
drop_any(X, [H|Xs], [H|L]) :- drop_any(X, Xs, L).

drop_first(X, L, NL) :- drop_any(X, L, NL), !.

drop_last(X, [H|Xs], [H|L]) :- drop_last(X, Xs, L), !.
drop_last(X, [X|T], T).

%??? drop first multiple times?
drop_all(X, [], []).
drop_all(X, [Y|T1], L) :- copy_term(X,Y), !, drop_all(X, T1, L), !. %X is a template
drop_all(X, [H|Xs], [H|L]) :- drop_all(X, Xs, L).

from_list([_], []).
from_list([H1, H2|T], [e(H1, H2)|L]) :- from_list([H2|T],L).

from_circ_list([H|L], R) :- append([H|L],[H],CL), from_list(CL, R).

out_degree([],_,0).
out_degree([e(S,_)|T], S, N) :- out_degree(T, S, ON), N is ON + 1, !. 
out_degree([H|T], S, N) :- out_degree(T,S,N).

drop_node(G, N, OG) :- drop_all(e(N, _), G, G2), drop_all(e(_, N), G2, OG).

reaching(G,N,L) :- findall(E, member(e(N,E), G), L).

prepend_if_missing(E, L, L) :- member(E,L), !.
prepend_if_missing(E, L, NL) :- append([E], L, NL).

nodes([], []).
nodes([e(SN, EN)|T], NL) :- nodes(T, L), prepend_if_missing(EN, L, TL), prepend_if_missing(SN, TL, NL).

%anypath([e(1,2),e(2,3),e(3,5)],1,5,L). 
anypath(G, SN, EN, [e(SN,EN)]) :- member(e(SN,EN), G).
anypath(G, SN, EN, [e(SN, N)|P]) :- member(e(SN,N), G), anypath(G, N, EN, P). % a ! here is better but then allreaching doesnt work

%allreaching([e(1,2),e(2,3),e(3,5)],1,[2,3,5]). 
allreaching(G, N, L) :- findall(E, anypath(G,N,E,R), L).

%???
interval (A , B , A ).
interval (A , B , X ):- A2 is A +1 , A2 < B , interval ( A2 , B , X).

neighbour (A , B , A , B2 ):- B2 is B +1.
neighbour (A , B , A , B2 ):- B2 is B -1.
neighbour (A , B , A2 , B):- A2 is A +1.
neighbour (A , B , A2 , B):- A2 is A -1.

gridlink (N , M , link (X , Y , X2 , Y2 )):-
	interval (0 , N , X ) ,
	interval (0 , M , Y ) ,
	neighbour (X , Y , X2 , Y2 ) ,
 	X2 >= 0, Y2 >= 0, X2 < N , Y2 < M.

next(Table, Player, Status, NewTable) :-
	make_move(Table, Player, NewTable),
	table_status(NewTable, Status).

%next([[x,x,'_'],['_','_','_'],['_','_','_']], x, nothing, N).
table_status(Table, Winning) :- check_win(Table, Winning), !.
table_status(Table, draw) :- check_draw(Table), !.
table_status(_, nothing).

check_win([[M,_,_],[M,_,_],[M,_,_]], R) :- if_player_build_message(M, R).
check_win([[_,M,_],[_,M,_],[_,M,_]], R) :- if_player_build_message(M, R).
check_win([[_,_,M],[_,_,M],[_,_,M]], R) :- if_player_build_message(M, R).

check_win([[M,M,M], [_,_,_], [_,_,_]], R) :- if_player_build_message(M, R).
check_win([_, [M,M,M], _], R) :- if_player_build_message(M, R).
check_win([_, _, [M,M,M]], R) :- if_player_build_message(M, R).

check_win([[M,_,_],[_,M,_],[_,_,M]], R) :- if_player_build_message(M, R).
check_win([[_,_,M],[_,M,_],[M,_,_]], R) :- if_player_build_message(M, R).

if_player_build_message(M,R) :- player(M), atom_concat('win(', M, IR), atom_concat(IR, ')', R).

player(x).
player(o).
switch_player(x, o).
switch_player(o, x).

full([E1,E2,E3]) :- player(E1), player(E2), player(E3).
check_draw([Row1,Row2,Row3]) :- full(Row1), full(Row2), full(Row3).

%next([[n,n,n],[n,n,n],[n,n,n]], x, nothing, N).
place_mark(['_'],Player,[Player]) :- !.
place_mark(['_'|T], Player, [Player|T]).
place_mark([Tile|T], Player, [Tile|NewTable]) :- place_mark(T,Player,NewTable).

make_move([Row1,Row2,Row3], Player, [NewRow1,Row2,Row3]) :- place_mark(Row1, Player, NewRow1).
make_move([Row1,Row2,Row3], Player, [Row1,NewRow2,Row3]) :- place_mark(Row2, Player, NewRow2).
make_move([Row1,Row2,Row3], Player, [Row1,Row2,NewRow3]) :- place_mark(Row3, Player, NewRow3).

next_if_not_done(Table, Player, Result, NewTable) :- copy_term(Result,nothing), next(Table, Player, Result, NewTable).

game(Table, _,_,[Table]).
game(Table, Player, Result, [Table, NewTable|T]) :- 
	next_if_not_done(Table, Player, Result, NewTable),
	switch_player(Player, NewPlayer), 
	game(NewTable, NewPlayer, Result, T).























