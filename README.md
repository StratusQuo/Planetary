# Planetary - A [P Language](https://github.com/p-org/P) Build Manager

Planetary is a command-line tool designed to simplify the management and building of [P](https://github.com/p-org/P) projects. It provides a streamlined approach to initializing, templating, and checking P projects, making it easier to get started on a project right away.

## Features

* **Project Initialization:** Quickly set up a new P project with the necessary directory structure and configuration files.
* **Template Generation:** Create a template for an existing P project, allowing for consistent project organization.
* **Error Checking:** Perform basic error checking on P projects to identify potential issues early on.
* **User-Friendly Interface:** Simple and intuitive command-line interface for ease of use.

## Installation

1. **Prerequisites:** Ensure you have the following installed:
   * OCaml
   * Dune
  
2. **Build and Install:**
   
   ```bash
   dune build @install
   ```

## Usage

```
Planetary - P Language Project Manager

Usage:
  planetary init <project_name> [-s <folder>] - Initialize a new P project
  planetary template <project_name> - Generate a template for an existing project
  planetary help - Display this help message

Options:
  -s <folder> - Skip creating the specified folder (can be used multiple times)
```

## Examples

* **Initialize a new project named "TCP":**
  ```bash
  planetary init TCP
  ```
  Planetary should generate all the folders necessary as well as a PProj file for you to get started:

  <img width="1005" alt="image" src="https://github.com/user-attachments/assets/40f4b753-5a61-48ac-acba-4b53246caef6">
  <img width="866" alt="image" src="https://github.com/user-attachments/assets/3a58d4d6-a1ef-4620-847b-1988365fcbe0">



  


* **Generate a template for an existing project named "TCP":**

  You can also use Planetary to generate a `.PProj` file for existing projects:  

  ```bash
  planetary template existing_project
  ```

  <img width="708" alt="image" src="https://github.com/user-attachments/assets/f377a42a-bc7f-4e3c-9b8e-994534697190">

  - **Note**: There's a bug where this command only works when executed from a directory _above_ the existing project. A fix for this should be coming soon.
 

* **Initialize a project while skipping the PSPEC folder:**
  ```bash
  planetary init my_p_project -s PSPEC
  ```

## Contributing

Contributions are welcome! Please feel free to open issues or submit pull requests.
