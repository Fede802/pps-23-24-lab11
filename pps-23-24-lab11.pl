search2(E, [E,E|T]).
search2(E, [H|T]) :- search2(E, T).
