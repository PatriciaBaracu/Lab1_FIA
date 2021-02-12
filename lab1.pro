:-dynamic(known/2).

top_goal:-
    guest( Guest ),
    nl, write("Tourist: "), write( Guest ), nl,
    write(" The guest is '"), write( Guest ), write("' !"), nl,
    !.
top_goal:-
    nl, write("INTRUDER"), nl,
    write("The origin of the tourist is unknown !"), nl,
    !, fail.

guest_type(earth):-
    has_pupils(yes),
    height(less_than_two_metres),
	has_wings(no),
    has_limbs(yes),
    nr_of_eyes(two_eyes),
    nr_of_fingers(five_fingers).


guest_type(outer_space):-
    has_pupils(no),
    has_limbs(yes),
    height(higher_than_two_and_half_metres),
    ( nr_of_eyes(one_eye);
    nr_of_eyes(three_eyes);
    nr_of_eyes(multi_eyes)
    ).
    
guest(british__planet_earth):-
    guest_type(earth),
    religion(christianity),
    skin_color(light_beige).

guest(algerian__planet_earth):-
    guest_type(earth),
    religion(islam),
    skin_color(bronze).

guest( bolivian__planet_earth):-
     guest_type(earth),
    religion(roman_catholic),
    skin_color(expresso).

guest(indian__planet_earth):-
    guest_type(earth),
    religion(hinduism),
    skin_color(deep_golden ).

guest(chinese__planet_earth):-
    guest_type(earth),
    religion(buddhism),
    skin_color(warm_beige).



guest(loonie):-
    guest_type(outer_space),
	
     ( 
      skin_color(dark_blue);
      skin_color(aqua);
      skin_color(yellow);
      skin_color(red);
      skin_color(purple)
    ),
     has_tentacles(yes),
  religion(tenguriism),
     nr_of_fingers(three_finger).



guest(space_guards__selenian_satellite):-
    guest_type(outer_space),
   skin_color(silver),
     has_wings(yes),
     has_handgun(yes),
     religion(ashurism ),
     nr_of_fingers(six_fingers).


height( Val ):- has(height, Val).
has_pupils( Val):- has(has_pupils, Val). 
nr_of_eyes( Val):- has(nr_of_eyes, Val). 
has_wings( Val ):- has(has_wings, Val).
has_handgun( Val ):- has(has_handgun, Val).
skin_color( Val ):- has(skin_color, Val).
has_limbs( Val):- has(has_limbs, Val).
religion( Val ):- has(religion, Val).
nr_of_fingers( Val ):- has(nr_of_fingers, Val).
has_tentacles( Val ):- has(nr_of_fingers, Val).


has(Atr,Val):-
    known(Atr, LVal),
    check_List(Val, LVal),
    !.
has(Atr, Val):-
	\+ known( Atr, _ ),
    menuAsk(Atr , _ ),
    has(Atr, Val),
    !.

saveResponse( _, [] ):-
    !,fail.
saveResponse( Atr, Val ):-
    \+ isList(Val),
    assertz( known( Atr, [Val] ) ),
    !.
saveResponse( Atr, LVal ):-
    assertz( known( Atr, LVal) ).


menuAsk( Atr, InputVal ):-
    nl, write( "Type the guest's " ), 
    write( Atr ),
    write( " value! " ),
    showMenu( Atr ), nl,
	read( Input ),
    processInput( Input, ProcessedInput ),
    menu_Validate_Input( Atr, ProcessedInput, InputVal ),
    saveResponse( Atr, InputVal ).
   
inputPossib( y, yes ):-!.
inputPossib( n, no ):-!.
inputPossib( Input, Input ):-!.

processInput( H1, [H2] ):-
    \+ isList(H1),
    inputPossib( H1, H2 ),
    !.
processInput( [H1], [H2] ):-
    inputPossib( H1, H2 ), 
    !.
processInput( [H1|T1], [H2|T2] ):-
    inputPossib( H1, H2 ),
    processInput( T1, T2 ),
    !.

menu_Validate_Input( Atr, Input, Input ):-
    menuList( Atr, MenuList ),
    check_List( Input, MenuList ),
    !.
menu_Validate_Input(Atr, _, Val):-
    nl, write("Invalid input !"), nl,
	menuAsk( Atr, Val),
    !.
check_List( X, List ):-
	isList( X ),
    check_Handler_List(X, List),
    !.
check_List( E, List ):-
    check_Handler_Element(E, List).
    
check_Handler_Element( E, [E|_] ):-!.
check_Handler_Element( E, [_|T] ):-
	check_List( E, T).

check_Handler_List( [], _ ):-!.
check_Handler_List( [H|T], List ):-
    check_Handler_Element( H, List ),
    check_Handler_List( T, List ).

isList([_|_]):-!.
isList([]):-!.


yesNoAns( [yes, no, y, n] ).

menuList( yes_no, List ):-yesNoAns( List ).
menuList( has_pupils, List ):- yesNoAns( List ).
menuList( has_handgun, List ):- yesNoAns( List ).
menuList( nr_of_eyes,   [two_eyes, one_eye, three_eyes, multi_eyes]).
menuList(  has_wings, List ):- yesNoAns( List ).
menuList(  has_limbs, List ):- yesNoAns( List ).
menuList(height,   [less_than_two_metres, higher_than_two_and_half_metres] ).
menuList(religion,  [islam, tenguriism, ashurism, christianity, roman_catholic, hinduism]).
menuList(skin_color,  [ n, no, warm_beige,expresso, bronze, light_beige, deep_golden, dark_blue, aqua, yellow, red, purple, silver]).
menuList(nr_of_fingers, [five_fingers, six_fingers, three_fingers]).
menuList(has_tentacles, List ):- yesNoAns( List ).


known(_,_):-fail. 

showMenu( MenuType ):-
    nl, write( "Options:"),
    menuList( MenuType, MenuList ),
    showMenuList(MenuList).
showMenuList([]):-
    write(".").
showMenuList( [H|T] ):-
    write(", "),
    write(H),
    showMenuList(T).




characteristics(british__planet_earth, religion_christianity_and_skin_color_light_beige).
characteristics(algerian__planet_earth , religion_islam_and_skin_color_bronze ).

choose_category:-
write("Whose characteristics do you wish to know?"),
read(Input), characteristics(Input,Output),
write("The the basic characteristics of "), write(Input),
write("   are  "), write(Output), write(".").


