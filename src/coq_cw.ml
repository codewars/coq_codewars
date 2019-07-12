open Pp

let solution_file = "/workspace/Solution.v"

let passed msg = Feedback.msg_notice (str ("\n<PASSED::> " ^ msg ^ "\n"))

let failed msg = Feedback.msg_notice (str ("\n<FAILED::> " ^ msg ^ "\n"))

(* unused *)
(* let extract_axioms s =
  let fold t typ accu =
    match t with
    | Printer.Variable _ -> failwith "Variable"
    | Printer.Opaque _ -> failwith "Opaque"
    | Printer.Transparent _ -> failwith "Transparent"
    | Printer.Axiom _ -> typ :: accu
  in
  Printer.ContextObjectMap.fold fold s [] *)

(* TODO: compare axiom names (constants) also *)
let test_assumptions msg env sigma s ax_tys =
  let unify ty1 ty2 = 
    match Reductionops.infer_conv env sigma ty1 ty2 with
    | Some _ -> true
    | None -> false
  in
  let iter t ty =
    match t with
    | Printer.Axiom _ ->
      let ety = EConstr.of_constr ty in
      if List.exists (unify ety) ax_tys then ()
      else begin
        failed msg;
        CErrors.user_err (str "Axiom: " ++ Printer.pr_econstr_env env sigma ety)
      end
    | _ -> ()
  in
  Printer.ContextObjectMap.iter iter s

(* Based on the PrintAssumptions code from vernac/vernacentries.ml *)
let locate r =
  try
    let gr = Smartlocate.locate_global_with_alias r in
    (gr, Globnames.printable_constr_of_global gr)
  with Not_found -> CErrors.user_err (str "Not found: " ++ Libnames.pr_qualid r)

let test ?(msg = "Axioms") c_ref ax_refs = 
  let env = Global.env() in
  let sigma = Evd.from_env env in
  let (gr, cstr) = locate c_ref in
  let st = Conv_oracle.get_transp_state (Environ.oracle (Global.env())) in
  let assumptions = Assumptions.assumptions st gr cstr in
  let ax_grs_cstrs = List.map locate ax_refs in
  let sigma, ax_tys = 
    List.fold_left 
      (fun (sigma, tys) (_, c) ->
        let sigma, ty = Typing.type_of env sigma (EConstr.of_constr c) in
        sigma, ty :: tys) (sigma, []) ax_grs_cstrs in
  test_assumptions msg env sigma assumptions ax_tys;
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

(** Tests that the file's content matches a given regular expression*)
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


