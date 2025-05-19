{ config
, pkgs
, inputs
, lib
, ...
}:

{
  services.prometheus = {
    enable = true;
    port = 9001;
    configText = ''
      scrape_configs:
        - job_name: 'spring-boot-app'
          metrics_path: '/actuator/prometheus'
          static_configs:
            - targets: ['localhost:8080']
    '';

  };
}
