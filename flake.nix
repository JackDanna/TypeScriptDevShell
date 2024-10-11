{
  description = "A TypeScript Dev Shell";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in 
  {
    # You can excute this command with "nix run"
    packages.${system} = {
      default = pkgs.writeShellScriptBin "run" ''
        nix develop -c -- codium .
      '';
    };
    

    devShells.${system}.default =
      pkgs.mkShell rec {
        name = "TypeScriptDevShell";
        buildInputs = with pkgs; [
          nodejs_22
          bashInteractive
          (vscode-with-extensions.override  {
            vscode = pkgs.vscodium;
            vscodeExtensions = with pkgs.vscode-extensions; [
              jnoortheen.nix-ide
              mhutchie.git-graph
              vscodevim.vim
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
              # {
              #   name = "vscode-edit-csv";
              #   publisher = "janisdd";
              #   version = "0.8.2";
              #   sha256 = "sha256-DbAGQnizAzvpITtPwG4BHflUwBUrmOWCO7hRDOr/YWQ=";
              # }
            ];
          })

        ];

        shellHook = ''
          export PS1+="${name}> "
          echo "Welcome to the Typescipt Dev Shell"
        '';
      };
  }; 

}

