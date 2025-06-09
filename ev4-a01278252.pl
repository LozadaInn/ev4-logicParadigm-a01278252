% Declaración de transiciones
transicion(a, elegir_funcionalidad, b).

transicion(b, recomendacion_genero, c).
transicion(b, recomendacion_animo, d).
transicion(b, mostrar_info_cancion, e).

transicion(c, seleccionar_genero, f).
transicion(f, mostrar_canciones_genero, g).
transicion(g, finalizar, h).
transicion(g, volver_menu, b).

transicion(d, seleccionar_animo, i).
transicion(i, mostrar_canciones_animo, j).
transicion(j, finalizar, h).
transicion(j, volver_menu, b).

transicion(e, ingresar_nombre_cancion, k).
transicion(k, mostrar_info_cancion, l).
transicion(l, finalizar, h).
transicion(l, volver_menu, b).

transicion(h, salir, fin).

% Estados de aceptación
estado_aceptacion(h).
estado_aceptacion(fin).

% Automata/1: Punto de entrada principal y estados finales
automata(a) :-
    write('Bienvenido. ¿Qué deseas hacer?'), nl,
    write('1. Recomendación por género'), nl,
    write('2. Recomendación por ánimo'), nl,
    write('3. Mostrar información de una canción'), nl,
    read(Opcion),
    ( Opcion = 1 -> automata(b, recomendacion_genero)
    ; Opcion = 2 -> automata(b, recomendacion_animo)
    ; Opcion = 3 -> automata(b, mostrar_info_cancion)
    ; write('Opción no válida.'), nl, automata(a)
    ).

automata(g) :-
    write('¿Deseas volver al menú o finalizar? (volver/finalizar)'), nl,
    read(Opcion),
    ( Opcion = volver -> automata(a)
    ; Opcion = finalizar -> automata(h)
    ; write('Opción no válida.'), nl, automata(g)
    ).

automata(j) :-
    write('¿Deseas volver al menú o finalizar? (volver/finalizar)'), nl,
    read(Opcion),
    ( Opcion = volver -> automata(a)
    ; Opcion = finalizar -> automata(h)
    ; write('Opción no válida.'), nl, automata(j)
    ).

automata(l) :-
    write('¿Deseas volver al menú o finalizar? (volver/finalizar)'), nl,
    read(Opcion),
    ( Opcion = volver -> automata(a)
    ; Opcion = finalizar -> automata(h)
    ; write('Opción no válida.'), nl, automata(l)
    ).

automata(h) :-
    write('Gracias por usar el sistema. ¿Salir? (si/no)'), nl,
    read(Opcion),
    ( Opcion = si -> automata(fin)
    ; Opcion = no -> automata(a)
    ; write('Opción no válida.'), nl, automata(h)
    ).

automata(fin) :-
    write('Hasta luego!'), nl.

% Automata/2: Transiciones con opciones específicas
automata(b, recomendacion_genero) :-
    write('¿Qué género prefieres? (pop/rock/rap)'), nl,
    read(Genero),
    automata(c, seleccionar_genero, Genero).

automata(b, recomendacion_animo) :-
    write('¿Qué ánimo tienes? (feliz/triste/epico/energetico/nostalgico/motivador)'), nl,
    read(Animo),
    automata(d, seleccionar_animo, Animo).

automata(b, mostrar_info_cancion) :-
    write('¿De qué canción deseas información? (escribe el nombre entre comillas simples)'), nl,
    read(Nombre),
    automata(e, ingresar_nombre_cancion, Nombre).

% Automata/3: Manejo de géneros y ánimos
automata(c, seleccionar_genero, Genero) :-
    findall(Nombre, cancion(Nombre, Genero, _, _, _), Lista),
    ( Lista = [] -> write('No hay canciones de ese género.'), nl
    ; write('Canciones recomendadas:'), nl, mostrar_lista(Lista)
    ),
    automata(g).

automata(d, seleccionar_animo, Animo) :-
    findall(Nombre, cancion(Nombre, _, Animo, _, _), Lista),
    ( Lista = [] -> write('No hay canciones para ese ánimo.'), nl
    ; write('Canciones recomendadas:'), nl, mostrar_lista(Lista)
    ),
    automata(j).

automata(e, ingresar_nombre_cancion, Nombre) :-
    ( cancion(Nombre, Genero, Animo, Artista, Año) ->
        write('Información de la canción:'), nl,
        write('Nombre: '), write(Nombre), nl,
        write('Género: '), write(Genero), nl,
        write('Ánimo: '), write(Animo), nl,
        write('Artista: '), write(Artista), nl,
        write('Año: '), write(Año), nl
    ; write('No se encontró la canción.'), nl
    ),
    automata(l).

% Utilidad para mostrar listas
mostrar_lista([]).
mostrar_lista([H|T]) :- write('- '), write(H), nl, mostrar_lista(T).

% Base de datos de canciones
cancion('Bachata Rosa', bachata, romantico, 'Juan Luis Guerra', 1990).
cancion('Darte un Beso', bachata, romantico, 'Prince Royce', 2013).
cancion('Te Extraño', bachata, nostalgico, 'Tercer Cielo', 2009).
cancion('Cuando Me Digan', bachata, melancolico, 'Frank Reyes', 2002).
cancion('La Bilirrubina', bachata, energetico, 'Juan Luis Guerra', 1990).

cancion('Perfect', pop, romantico, 'Ed Sheeran', 2017).
cancion('All of Me', pop, romantico, 'John Legend', 2013).
cancion('Someone Like You', pop, nostalgico, 'Adele', 2011).
cancion('Back to December', pop, melancolico, 'Taylor Swift', 2010).
cancion('Blinding Lights', pop, energetico, 'The Weeknd', 2019).

cancion('Sweet Child O\' Mine', rock, romantico, 'Guns N\' Roses', 1987).
cancion('I Don\'t Want to Miss a Thing', rock, romantico, 'Aerosmith', 1998).
cancion('Wish You Were Here', rock, nostalgico, 'Pink Floyd', 1975).
cancion('Creep', rock, melancolico, 'Radiohead', 1992).
cancion('Livin\' on a Prayer', rock, energetico, 'Bon Jovi', 1986).

cancion('Como Quisiera', regional, romantico, 'La Banda MS', 2015).
cancion('Amor Eterno', regional, romantico, 'Rocío Dúrcal', 1984).
cancion('Te Amo', regional, nostalgico, 'Los Bukis', 1986).
cancion('El Perdón', regional, melancolico, 'Nicky Jam y Enrique Iglesias', 2015).
cancion('La Culebra', regional, energetico, 'Los Tigres del Norte', 1997).

