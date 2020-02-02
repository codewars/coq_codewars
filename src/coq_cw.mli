val test_axioms : ?msg:string -> Libnames.qualid -> Libnames.qualid list -> unit

val test_type : ?msg:string -> Libnames.qualid -> Constrexpr.constr_expr -> unit

val test_file_size : ?fname:string -> int -> unit

val test_file_regex : ?fname:string -> bool -> string -> unit

val compile_and_run : string list -> ?options:string -> string -> unit

val begin_group : string -> string -> unit

val end_group : string -> unit