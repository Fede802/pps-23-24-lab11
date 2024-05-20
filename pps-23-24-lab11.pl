%search2(a, [c,a,a,d,a,a]). -> yes, two solution
%search2(a, [c,a,a,a]). -> yes, two solution
%search2(a, [c,a,a,b]). -> yes
%search2(a, L). -> yes, infinite solution
%search2(a, [_,a,_a,_]). -> yes, three solution
search2(E, [E,E|T]).
search2(E, [H|T]) :- search2(E, T).

%search_two(a, [b,c,a,a,d,e]). ? no
%search_two(a, [b,c,a,d,a,d,e]). ? yes
search_two(E, [E,_,E|T]).
search_two(E, [H|T]) :- search_two(E, T).

%size([b,c,a,d,a,d,e], 7). ? yes
%size(X,Y). -> fully relational
size([], 0).
size([H|T], S) :- size(T, TS), S is TS + 1.

%sum([1,2,3], X). ? yes, X/6
sum([], 0).
sum([H|T], S) :- sum(T, TS), S is TS + H.

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

%split ([10 ,20 ,30 ,40 ,50] ,2 ,L1 ,L2)
split(L, 0, [], L).
split([H|T], N, [H|T2], T3) :- NN is N - 1, split(T, NN, T2, T3), !.

rotate([H,L], RL) :- append(L, [H], RL).

range(L,H,L).
range(L,H,O) :- NL is L + 1, NL < H, range(NL, H, O).
dice2(X) :- range(1,7,X).

dice(X) :- member(X, [1,2,3,4,5,6]).

three_dice(S, [X,Y,Z]) :- dice(X), dice(Y), dice(Z), S is X + Y + Z.

drop_any(X, [X|T], T).
drop_any(X, [H|Xs], [H|L]) :- drop_any(X, Xs, L).

drop_first(X, L, NL) :- drop_any(X, L, NL), !.

drop_last(X, [H|Xs], [H|L]) :- drop_last(X, Xs, L), !.
drop_last(X, [X|T], T).

%???
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


