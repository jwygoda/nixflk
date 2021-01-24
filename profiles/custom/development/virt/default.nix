{ pkgs, ... }: {
  virtualisation = {
    containers.enable = true;

    docker.enable = true;

    podman.enable = true;
    oci-containers.backend = "podman";
  };

  environment.systemPackages = with pkgs; [ docker-compose ];
}
