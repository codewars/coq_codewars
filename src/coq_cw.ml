open Pp

(* unused *)
let extract_axioms s =
  let fold t typ accu =
    match t with
    | Printer.Variable _ -> failwith "Variable"
    | Printer.Opaque _ -> failwith "Opaque"
    | Printer.Transparent _ -> failwith "Transparent"
    | Printer.Axiom _ -> typ :: accu
  in
  Printer.ContextObjectMap.fold fold s []

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
        Feedback.msg_notice (str ("\n<FAILED::> " ^ msg ^ "\n"));
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
  Feedback.msg_notice (str ("\n<PASSED::> " ^ msg ^ "\n"))
