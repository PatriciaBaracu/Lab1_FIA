# Lab1_FIA


Rule based system in Prolog programming language

An expert system that describes types of tourists that visit Luna-City and collect info in the database of
at least 5 tourist types and the criteria by which they can be distinguished from Loonies
and between themselves (i.e. clothes, accent, gait, height and opinion on politics).

Technologies<br/>
Prolog 

How to run the program?

Download Prolog from the link provided below:

https://www.swi-prolog.org/Download.html


The basic predicate top_goal that is called in order to run the code and figure out the origin of tourist (check out the part written below)


top_goal:- <br/>
    guest( Guest ),<br/>
    nl, write("Tourist: "), write( Guest ), nl, <br/>
    write(" The guest is '"), write( Guest ), write("' !"), nl,<br/>
    !.<br/>
top_goal:-<br/>
    nl, write("INTRUDER"), nl,<br/>
    write("The origin of the tourist is unknown !"), nl,<br/>
    !, fail.<br/>
