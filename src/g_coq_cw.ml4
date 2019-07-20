DECLARE PLUGIN "coq_cw_plugin"

open Stdarg

VERNAC COMMAND EXTEND CWAssert CLASSIFIED AS QUERY
| [ "CWAssert" string_opt(msg) ref(e) "Assumes" ref_list(axioms)] -> [ 
        Coq_cw.test_axioms ?msg e axioms
    ]
END

VERNAC COMMAND EXTEND CWTest CLASSIFIED AS QUERY
| [ "CWTest" string_opt(msg) ref(e) "Assumes" ref_list(axioms)] -> [ 
        Coq_cw.test_axioms ?msg e axioms
    ]
END

VERNAC COMMAND EXTEND CWGroup CLASSIFIED AS SIDEFF
| [ "CWGroup" string(msg)] -> [ 
        Coq_cw.begin_group "DESCRIBE" msg
    ]
END

VERNAC COMMAND EXTEND CWEndGroup CLASSIFIED AS SIDEFF
| [ "CWEndGroup"] -> [
        Coq_cw.end_group "DESCRIBE"
    ]
END

VERNAC COMMAND EXTEND CWTestCase CLASSIFIED AS SIDEFF
| [ "CWTestCase" string(msg)] -> [ 
        Coq_cw.begin_group "IT" msg
    ]
END

VERNAC COMMAND EXTEND CWEnd CLASSIFIED AS SIDEFF
| [ "CWEnd"] -> [
        Coq_cw.end_group "IT"
    ]
END

VERNAC COMMAND EXTEND CWFileSize CLASSIFIED AS QUERY
| [ "CWFile" string_opt(fname) "Size" "<" int(size)] -> [ 
        Coq_cw.test_file_size ?fname size
    ]
END

VERNAC COMMAND EXTEND CWFileMatch CLASSIFIED AS QUERY
| [ "CWFile" string_opt(fname) "Matches" string(regex)] -> [ 
        Coq_cw.test_file_regex ?fname true regex
    ]
END

VERNAC COMMAND EXTEND CWFileNegMatch CLASSIFIED AS QUERY
| [ "CWFile" string_opt(fname) "Does" "Not" "Match" string(regex)] -> [ 
        Coq_cw.test_file_regex ?fname false regex
    ]
END