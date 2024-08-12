(* Planetary.ml *)

open Arg

(*
╔═══════════════════════════════════════════════════════════════════╗ 
║   ⇩ CLI Arguments                                                 ║  
╚═══════════════════════════════════════════════════════════════════╝*)

type command = Init | Template | Help
let command = ref Help
let project_name = ref ""
let skip_folders = ref []

(* Function to parse command *)
let parse_command cmd =
  match cmd with
  | "init" -> command := Init
  | "template" -> command := Template
  | _ -> command := Help


(* Argument specifications for the command line parser *)
let specs = [
  ("-s", String (fun f -> skip_folders := f :: !skip_folders), "Folder to skip (PSrc, PSpec, PTst, PForeign)");
]

(* Initialize Spectrum formatting for colored output *)
let reset_ppf = Spectrum.prepare_ppf Format.std_formatter


(*
╔═══════════════════════════════════════════════════════════════════╗ 
║   ⇩ Directory and File Creation                                   ║  
╚═══════════════════════════════════════════════════════════════════╝*)

(* Directory Creation *)
let create_dir dir_name = 
  if not (Sys.file_exists dir_name) then Unix.mkdir dir_name 0o755

let create_file file_name content = 
  let oc = open_out file_name in 
  Spectrum.Simple.printf "@{<blue>Creating file:@} @{<green>%s@}\n" file_name;
  Printf.fprintf oc "%s" content;
  close_out oc

(* Function to generate the default P project template *)
let generate_pproj_template project_name = 
  let content = 
    Printf.sprintf 
      "<Project>\n\
       <ProjectName>%s</ProjectName>\n\
       <InputFiles>\n\
       \t<PFile>./PSrc/</PFile>\n\
       \t<PFile>./PSpec/</PFile>\n\
       \t<PFile>./PTst/</PFile>\n\
       \t<PFile>./PForeign/</PFile>\n\
       </InputFiles>\n\
       <OutputDir>./PGenerated/</OutputDir>\n\
       </Project>\n" project_name
  in
  let file_path = Filename.concat project_name (project_name ^ ".pproj") in
  create_file file_path content

(* Function to set up the project structure *)
let setup_project project_name =
  Spectrum.Simple.printf "@{<bold,yellow>\nSetting up project structure...@}\n\n";
  create_dir project_name;
  List.iter (fun folder ->
    if not (List.mem folder !skip_folders) then (
      let folder_path = Filename.concat project_name folder in
      create_dir folder_path;
      Spectrum.Simple.printf "@{<green>Created directory:@} @{<blue>%s@}\n" folder_path
    )
  ) ["PSrc"; "PSpec"; "PTst"; "PForeign"];
  generate_pproj_template project_name


(* Function to check the project for errors *)
let check_project project_name =
  Spectrum.Simple.printf "@{<bold,yellow>\nChecking project for errors...@}\n";
  let cmd = Printf.sprintf "pc -proj:%s.pproj" project_name in
  ignore (Sys.command cmd) (* Replace with actual error checking logic *)

(* Function to display help *)
let display_help () =
  Spectrum.Simple.printf "@{<bold,yellow>Planetary - P Language Project Manager@}\n\n";
  Spectrum.Simple.printf "Usage:\n";
  Spectrum.Simple.printf "  @{<green>planetary init <project_name> [-s <folder>]@} - Initialize a new P project\n";
  Spectrum.Simple.printf "  @{<green>planetary template <project_name>@} - Generate a template for an existing project\n";
  Spectrum.Simple.printf "  @{<green>planetary help@} - Display this help message\n\n";
  Spectrum.Simple.printf "Options:\n";
  Spectrum.Simple.printf "  @{<blue>-s <folder>@} - Skip creating the specified folder (can be used multiple times)\n"


(*
╔═══════════════════════════════════════════════════════════════════╗ 
║   ⇩ Main Function and Program Entry Point                         ║  
╚═══════════════════════════════════════════════════════════════════╝*)

(* Main function *)
let main () =
  let handle_anonymous_arg arg =
    match !command with
    | Help -> parse_command arg
    | _ -> project_name := arg
  in
  Arg.parse specs handle_anonymous_arg "Usage: planetary <command> [options]";
  
  match !command with
  | Init ->
      if !project_name = "" then (
        Spectrum.Simple.printf "@{<bg:purple fg:white>\n ERROR @}@{<bg:white fg:black> Project name is required for init command. @}\n";
        exit 1
      );
      setup_project !project_name;
      check_project !project_name;
      Spectrum.Simple.printf "@{<bold,green>P project '%s' initialized successfully!@}\n" !project_name
  | Template ->
      if !project_name = "" then (
        Spectrum.Simple.printf "@{<bg:purple fg:white>\n ERROR @}@{<bg:white fg:black> Project name is required for template command. @}\n";
        exit 1
      );
      generate_pproj_template !project_name;
      Spectrum.Simple.printf "@{<bold,green>Template generated for project '%s'!@}\n" !project_name
  | Help ->
      display_help ()

(* Entry point *)
let () = 
  main ();
  reset_ppf () (* Reset the formatter when done *)


