%utils
range(L, H, L).
range(L, H, O) :- NL is L + 1, NL < H, range(NL, H, O).

prepend_if_missing(E, L, L) :- member(E,L), !.
prepend_if_missing(E, L, NL) :- append([E], L, NL).
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
%max_min([3,1,5], X, Y). -> yes, X/5 Y/1
max_min([], Max, Max, Min, Min).
max_min([H|T], TMax, Max, TMin, Min) :- H >= TMax, max_min(T, H, Max, TMin, Min).
max_min([H|T], TMax, Max, TMin, Min) :- H =< TMin, max_min(T, TMax, Max, H, Min).
max_min([H|T], Max, Min) :- max_min(T, H, Max, H, Min), !.
%max_min2([3,1,5], X, Y). -> yes, X/5 Y/1
max_min2([H], H, H).
max_min2([H|T], H, Min) :- max_min2(T, Max, Min), H >= Max, !.
max_min2([H|T], Max, H) :- max_min2(T, Max, Min), H =< Min, !.
max_min2([H|T], Max, Min) :- max_min2(T, Max, Min).

%Ex 1.6
%split(List1, Elements, SubList1, SubList2)
%Examples:
%split([10,20,30,40,50], 2, L1, L2). -> yes, L1/[10,20] L2/[30,40,50]
split(L2, 0, [], L2).
split([H|T], N, [H|T2], L2) :- NN is N - 1, split(T, NN, T2, L2), !.

%Ex 1.7
%rotate(List, RotatedList)
%Examples:
%rotate([10,20,30,40], L). -> yes, L/[20,30,40,10]
rotate([H|L], RL) :- append(L, [H], RL).

%Ex 1.8
%dice(X)
%Examples:
%dice(X). -> yes, X/1; X/2; ... X/6
dice(X) :- member(X, [1,2,3,4,5,6]).
dice2(X) :- range(1, 7, X).

%Ex 1.9
%three_dice(TotalFaceSum, FacesResultList).
%Examples:
%three_dice(5,L). -> yes, L/[1 ,1 ,3]; L/[1 ,2 ,2];...;L/[3 ,1 ,1]
three_dice(S, [X,Y,Z]) :- dice(X), dice(Y), dice(Z), S is X + Y + Z.

%-----------------------------------------------------------------------------------------Ex 2-----------------------------------------------------------------------------------------
%Ex 2.1
%drop_any(?Elem, ?List, ?OutList)
%Examples:
%drop_any(10, [10,20,10,30,10], L). -> yes, L/[20,10,30,10]; L/[10,20,30,10]; L/[10,20,10,30]
drop_any(E, [E|T], T).
drop_any(E, [H|T], [H|L]) :- drop_any(E, T, L).

%Ex 2.2
%drop_first(?Elem, ?List, ?OutList)
%Examples:
%drop_first(10, [10,20,10,30,10], L). -> yes, L/[20,10,30,10]
drop_first(E, L, OL) :- drop_any(E, L, OL), !.

%drop_last(?Elem, ?List, ?OutList)
%Examples:
%drop_last(10, [10,20,10,30,10], L). -> yes, L/[10,20,10,30]
drop_last(E, [H|T], [H|L]) :- drop_last(E, T, L), !.
drop_last(E, [E|T], T).

%drop_all(?Elem, ?List, ?OutList)
%Examples:
%drop_all(10, [10,20,10,30,10], L). -> yes, L/[20,30]
drop_all(E, [], []).
drop_all(E, [CE|T1], OL) :- copy_term(E, CE), !, drop_all(E, T1, OL), !. %X is a template
drop_all(E, [H|T], [H|L]) :- drop_all(E, T, L).

drop_all2(E, L, OL) :- drop_first(E, L, TOL), drop_all2(E, TOL, OL), !.
drop_all2(E, L, L).

%-----------------------------------------------------------------------------------------Ex 3-----------------------------------------------------------------------------------------
%Ex 3.1
%from_list(+List, -Graph)
%Examples:
%from_list([1,2,3],[e(1,2),e(2,3)]).
%from_list([1,2],[e(1,2)]).
%from_list([1],[]).
from_list([_], []).
from_list([H1, H2|T], [e(H1, H2)|L]) :- from_list([H2|T],L).

%Ex 3.2
%from_circ_list(+List, -Graph)
%Examples:
%from_circ_list([1,2,3],[e(1,2),e(2,3),e(3,1)]).
%from_circ_list([1,2],[e(1,2),e(2,1)]).
%from_circ_list([1],[e(1,1)]).
from_circ_list([H|L], G) :- append([H|L], [H], CL), from_list(CL, G).

%Ex 3.3
%out_degree(+Graph, +Node, -Deg)
%Examples:
%out_degree([e(1,2), e(1,3), e(3,2)], 2, 0).
%out_degree([e(1,2), e(1,3), e(3,2)], 3, 1).
%out_degree([e(1,2), e(1,3), e(3,2)], 1, 2).
out_degree([], _, 0).
out_degree([e(N,_)|T], N, D) :- out_degree(T, N, OD), D is OD + 1, !. 
out_degree([H|T], N, D) :- out_degree(T, N, D).

%Ex 3.4
%drop_node(+Graph, +Node, -OutGraph)
%Examples:
%drop_node([e(1,2),e(1,3),e(2,3)], 1, [e(2,3)]).
drop_node(G, N, OG) :- drop_all(e(N, _), G, TOG), drop_all(e(_, N), TOG, OG).

%Ex 3.5
%reaching(+Graph, +Node, -List)
%Examples:
%reaching([e(1,2),e(1,3),e(2,3)], 1, L). -> yes, L/[2,3]
%reaching([e(1,2),e(1,2),e(2,3)], 1, L). -> yes, L/[2,2]).
reaching(G, N, L) :- findall(E, member(e(N,E), G), L).

%Ex 3.6
%nodes(+Graph, -Nodes)
%Examples:
%nodes([e(1,2),e(2,3),e(3,4)], L). -> yes, L/[1,2,3,4]
%nodes([e(1,2),e(1,3)], L). -> yes, L/[2,1,3].
nodes([], []).
nodes([e(SN, EN)|T], NL) :- nodes(T, L), prepend_if_missing(EN, L, TL), prepend_if_missing(SN, TL, NL).

%Ex 3.7
%anypath(+Graph, +StartNode, +EndNode, -ListPath)
%Examples:
%anypath([e(1,2),e(1,3),e(2,3)], 1, 3, L). -> yes, L/[e(1,3)]; L/[e(1,2),e(2,3)]

anypath(G, SN, EN, [e(SN,EN)]) :- write(4), member(e(SN,EN), G), write(5), nl.
anypath(G, SN, EN, [e(SN, N)|P]) :- write(1), member(e(SN,N), G), write(2), anypath(G, N, EN, P), !. 

%Ex 3.8
%allreaching(+Graph, +Node, -List)
%Examples:
%allreaching([e(1,2),e(2,3),e(3,5)], 1, [2,3,5]). 
allreaching(G, N, L) :- findall(E, (nodes(G, NL), member(E, NL), anypath(G,N,E,R)), L).

%Ex 3.9 ???
interval(A, B, A).
interval(A, B, X):- A2 is A + 1, A2 < B, interval(A2, B, X).

neighbour(A, B, A, B2):- B2 is B + 1.
neighbour(A, B, A, B2):- B2 is B - 1.
neighbour(A, B, A2, B):- A2 is A + 1.
neighbour(A, B, A2, B):- A2 is A - 1.

%gridlink(2,2,Arc). -> yes, Arc/e(0,1); Arc/e(0,2); Arc/e(1,0); Arc/e(1,3); Arc/e(2,3); Arc/e(2,0); Arc/e(3,2); Arc/e(3,1)
% node0 ? node1
%   ?       ?
% node2 ? node3
gridlink(Rows, Columns, e(StartNode, EndNode)):-
	interval(0, Rows, CurrentRow),
	interval(0, Columns, CurrentColumn),
	neighbour (CurrentRow, CurrentColumn, NeighbourRow, NeighbourColumn),
 	NeighbourRow >= 0, NeighbourColumn >= 0, NeighbourRow < Rows, NeighbourColumn < Columns,
 	StartNodeShift is CurrentRow * Columns,
 	StartNode is CurrentColumn + StartNodeShift,
 	EndNodeShift is NeighbourRow * Columns,
 	EndNode is NeighbourColumn + EndNodeShift.

build_graph(Rows, Columns, Graph) :- findall(Edge, gridlink(Rows, Columns, Edge), Graph).

list_length([], 0).
list_length([_|T], L) :- list_length(T, N), L is N + 1.
%build_graph(3,3,G), allreachingmaxhops(G, 1, L, 1). %fix anypath to avoid loop
allreachingmaxhops(G, N, L, MaxHops) :- findall(P, (anypath(G,N,E,P), list_length(P, Len), Len =< MaxHops), L).


%-----------------------------------------------------------------------------------------Ex 4-----------------------------------------------------------------------------------------
%player

player(x).
player(o).

switch_player(x, o).
switch_player(o, x).

if_player_build_win_message(M,R) :- player(M), atom_concat('win(', M, IR), atom_concat(IR, ')', R).

%next(@Table, @Player, -Result, -NewTable)
%Examples:
%next([['_','_','_'],['_','_','_'],['_','_','_']], x, S, NT).
next(Table, Player, Status, NewTable) :-
	make_move(Table, Player, NewTable),
	table_status(NewTable, Status).

make_move([Row1,Row2,Row3], Player, [NewRow1,Row2,Row3]) :- place_mark(Row1, Player, NewRow1).
make_move([Row1,Row2,Row3], Player, [Row1,NewRow2,Row3]) :- place_mark(Row2, Player, NewRow2).
make_move([Row1,Row2,Row3], Player, [Row1,Row2,NewRow3]) :- place_mark(Row3, Player, NewRow3).

place_mark(['_'],Player,[Player]) :- !. %optimization
place_mark(['_'|T], Player, [Player|T]).
place_mark([Tile|T], Player, [Tile|NewTable]) :- place_mark(T,Player,NewTable).

table_status(Table, WinningMsg) :- check_win(Table, WinningMsg), !.
table_status(Table, draw) :- check_draw(Table), !.
table_status(_, nothing).

check_win([[M,_,_],[M,_,_],[M,_,_]], R) :- if_player_build_win_message(M, R).
check_win([[_,M,_],[_,M,_],[_,M,_]], R) :- if_player_build_win_message(M, R).
check_win([[_,_,M],[_,_,M],[_,_,M]], R) :- if_player_build_win_message(M, R).

check_win([[M,M,M], [_,_,_], [_,_,_]], R) :- if_player_build_win_message(M, R).
check_win([_, [M,M,M], _], R) :- if_player_build_win_message(M, R).
check_win([_, _, [M,M,M]], R) :- if_player_build_win_message(M, R).

check_win([[M,_,_],[_,M,_],[_,_,M]], R) :- if_player_build_win_message(M, R).
check_win([[_,_,M],[_,M,_],[M,_,_]], R) :- if_player_build_win_message(M, R).

check_draw([Row1,Row2,Row3]) :- full(Row1), full(Row2), full(Row3).
full([E1,E2,E3]) :- player(E1), player(E2), player(E3).

%game(@Table, @Player, -Result, -TableList)
%game([['_','_','_'],['_','_','_'],['_','_','_']], x, S, TL).
game(Table, _, _,[Table]).
game(Table, Player, Status, [Table, NewTable|T]) :- 
	next_if_not_done(Table, Player, Status, NewTable),
	switch_player(Player, NewPlayer), 
	game(NewTable, NewPlayer, Status, T).

next_if_not_done(Table, Player, Status, NewTable) :- copy_term(Status,nothing), next(Table, Player, Status, NewTable).






















