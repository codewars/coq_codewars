open Pp

let solution_file = "/workspace/Solution.v"

let format_msg =
  let re = Str.regexp_string "\n" in
  Str.global_replace re "<:LF:>" 

let display tag msg =
  Feedback.msg_notice (str (Printf.sprintf "\n<%s::>%s\n" tag (format_msg msg)))

let passed = display "PASSED"

let failed = display "FAILED"

type group = {
  tag : string;
  start_time : float
}

let mk_group tag t = { tag = tag; start_time = t }

let group_stack = Summary.ref ~name:"open_groups" ([] : group list)

let rec end_group tag =
  let e = Unix.gettimeofday() in
  match !group_stack with 
  | [] -> CErrors.user_err (str "No open groups")
  | {tag = "IT"} :: g :: gs when tag <> "IT" ->
    end_group "IT"; end_group tag
  | g :: gs ->
    if g.tag <> tag then CErrors.user_err (str "Ending incorrect group");
    group_stack := gs;
    display "COMPLETEDIN" (Printf.sprintf "%.2f" ((e -. g.start_time) *. 1000.))

let begin_group tag name =
  let t = Unix.gettimeofday() in
  let () =
    match !group_stack with
    | {tag = "IT"} :: _ when tag = "IT" -> end_group "IT"
    | _ -> () in
  group_stack := mk_group tag t :: !group_stack;
  display tag name

(* Based on the PrintAssumptions code from vernac/vernacentries.ml *)
let assumptions r =
  try
    let gr = Smartlocate.locate_global_with_alias r in
    let cstr = Globnames.printable_constr_of_global gr in
    let st = Conv_oracle.get_transp_state (Environ.oracle (Global.env())) in
    Assumptions.assumptions st gr cstr
  with Not_found -> CErrors.user_err (str "Not found: " ++ Libnames.pr_qualid r)

let locate_constant r =
  try
    let gr = Smartlocate.locate_global_with_alias r in
    match gr with
    | Globnames.ConstRef cst -> cst
    | _ -> CErrors.user_err (str "A constant is expected: " ++ Printer.pr_global gr)
  with Not_found -> CErrors.user_err (str "Not found: " ++ Libnames.pr_qualid r)

let pr_axiom env sigma ax ty =
  match ax with
  | Printer.Constant kn -> 
    Printer.pr_constant env kn ++ str " : " ++ Printer.pr_ltype_env env sigma ty
  | _ -> str "? : "  ++ Printer.pr_ltype_env env sigma ty

let test_axioms ?(msg = "Axiom Test") c_ref ax_refs = 
  let env = Global.env() in
  let sigma = Evd.from_env env in
  let ax_csts = List.map locate_constant ax_refs in
  let ax_objs = List.map (fun c -> Printer.Axiom (Printer.Constant c, [])) ax_csts in
  let ax_set = Printer.ContextObjectSet.of_list ax_objs in
  let assums = assumptions c_ref in
  let iter t ty =
    match t with
    | Printer.Axiom (ax, _) ->
      if Printer.ContextObjectSet.mem t ax_set then ()
      else begin
        failed msg;
        CErrors.user_err (str "Prohibited Axiom: " ++ pr_axiom env sigma ax ty)
      end
    | _ -> ()
  in
  let () = Printer.ContextObjectMap.iter iter assums in
  passed msg

(** Tests that the file size is less than a given number *)
let test_file_size ?(fname = solution_file) size =
  try
    let stats = Unix.stat fname in
    if stats.Unix.st_size < size then
      passed (Format.sprintf "Size %d < %d" stats.Unix.st_size size)
    else begin
      let msg = Format.sprintf "Size %d >= %d" stats.Unix.st_size size in 
      failed msg;
      CErrors.user_err (str msg)
    end
  with Unix.Unix_error _ -> CErrors.user_err (str ("Bad file name: " ^ fname))

(** Tests that the file's content matches a given regular expression *)
let test_file_regex ?(fname = solution_file) match_flag regex =
  let re = Str.regexp regex in
  let ic = open_in fname in
  let n = in_channel_length ic in
  let s = really_input_string ic n in
  let () = close_in ic in
  let matched = try ignore (Str.search_forward re s 0); true
                with Not_found -> false in
  if matched = match_flag then
    passed "OK"
  else begin
    failed "Bad match";
    CErrors.user_err (str "Bad match")
  end
