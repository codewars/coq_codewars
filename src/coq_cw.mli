val test_axioms : ?msg:string -> Libnames.qualid -> Libnames.qualid list -> unit

val test_file_size : ?fname:string -> int -> unit

val test_file_regex : ?fname:string -> bool -> string -> unit