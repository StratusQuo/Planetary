(lang dune 3.16)

(name planetary)

(generate_opam_files true)

(source
 (github StratusQuo/planetary))

(authors "Chris c")

(maintainers "Chris C")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name planetary)
 (synopsis "A Build Manager for the P language")
 (description "A longer description")
 (depends ocaml dune spectrum)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
