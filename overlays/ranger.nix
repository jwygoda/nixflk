final: prev: {
  ranger = prev.ranger.overrideAttrs (o: {
    preConfigure = o.preConfigure + ''
      substituteInPlace ranger/core/main.py \
      --replace "if os.path.exists(path) and not os.access(path, os.W_OK):" ""
    '';
  });
}
