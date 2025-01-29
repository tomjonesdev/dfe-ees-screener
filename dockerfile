FROM r-base:4.4.2

RUN R -e "install.packages('pak')"
RUN R -e "pak::pkg_install('plumber')"
RUN R -e "pak::pkg_install('dfe-analytical-services/eesyscreener')"
RUN R -e "pak::pkg_install('readr')"

COPY / /

ENV RENV_PATHS_LIBRARY=renv/library

EXPOSE 80

ENTRYPOINT ["Rscript", "screen_controller.R"]