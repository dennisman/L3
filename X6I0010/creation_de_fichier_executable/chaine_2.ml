let rec list_of_string ch
=
if ch = ""
then []
else (String.get ch 0) :: list_of_string (String.sub ch 1 (String.length (ch) - 1)) ;;

let rec string_of_list lcar
=
if lcar = []
then ""
else (String.make 1 (List.hd (lcar))) ^  string_of_list (List.tl (lcar)) ;;

(**********)

let
  ch = read_line ()
in
  (print_int (String.length (ch)) ;
   print_newline ()) ;;

(**********)

let
ch = read_line ()
in
let
lcar = list_of_string (ch)
in
(print_int (List.length (lcar)) ;
 print_newline ()) ;;

(**********)

let
ch = read_line ()
in
let
adr_lcar = ref (list_of_string (ch))
in
let
adr_nc = ref 0
in
(while !adr_lcar <> [] do
(adr_nc := !adr_nc + 1 ;
adr_lcar := List.tl (!adr_lcar))
done ;
print_int (!adr_nc) ;
print_newline ()) ;;

(**********)
