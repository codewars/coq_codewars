DECLARE PLUGIN "coq_cw_plugin"

open Stdarg

VERNAC COMMAND EXTEND CWTest CLASSIFIED AS QUERY
| [ "CWTest" ref(e) "Assumes" ref_list(axioms)] -> [
    Coq_cw.test e axioms
    ]
END