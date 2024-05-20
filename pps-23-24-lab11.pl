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





