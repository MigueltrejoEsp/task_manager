{
  description = "Development shell for the Task manager project";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [ 
        beamMinimal27Packages.erlang
        beamMinimal27Packages.elixir_1_19
          beamMinimal27Packages.elixir-ls

        nodejs
        esbuild
        tailwindcss_4

        docker_28
        docker-compose
      ];

      env = {
        POSTGRES_USER = "postgres";
        POSTGRES_PASSWORD = "postgres";
        POSTGRES_HOST = "localhost";
        POSTGRES_DB = "task_manager_db_dev";
        POSTGRES_PORT = "5432";
        TAILWINDCSS_PATH="${pkgs.lib.getExe pkgs.tailwindcss_4}";
        TAILWINDCSS_VERSION="4.1.17";
        ESBUILD_PATH="${pkgs.lib.getExe pkgs.esbuild}";
        ESBUILD_VERSION="0.25.5";
      };

      shellHook = ''
        echo "################################################"
        echo "################################################"
        echo "###                                          ###"
        echo "###      Task Manager development shell      ###"
        echo "###                                          ###"
        echo "################################################"
        echo "################################################"
      '';
    };
  };
}
