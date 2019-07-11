DECLARE PLUGIN "coq_cw_plugin"

open Pp
open Stdarg

VERNAC COMMAND EXTEND CWTest CLASSIFIED AS QUERY
| [ "CWTest" string_opt(msg) ref(e) "Assumes" ref_list(axioms)] -> [ 
        Coq_cw.test ?msg e axioms
    ]
END

VERNAC COMMAND EXTEND CWGroup CLASSIFIED AS QUERY
| [ "CWGroup" string(msg)] -> [ 
        Feedback.msg_notice (str ("\n<DESCRIBE::> " ^ msg ^ "\n"))
    ]
END

VERNAC COMMAND EXTEND CWEndGroup CLASSIFIED AS QUERY
| [ "CWEndGroup"] -> [ 
        Feedback.msg_notice (str "\n<COMPLETEDIN::>\n")
    ]
END
