
# Configure base packages, because we load all packages from .Rprofile
packages_base <- c(
  "base",
  "methods",
  "utils",
  "stats",
  "graphics",
  "grDevices",
  "datasets")

# Set packages in order of load
packages_cran <- c(
  "purr",
  "quarto"
)

## Combine packages
packages <- c(packages_base, packages_cran)
packages_renv <- c(packages_cran)


# Configure renv
options(renv.snapshot.filter = function(project) {
  return(packages_renv)
})

renv::restore()


# Load packages
# TODO Set to TRUE when adding packages to check if there are problematic conflicts
warn_conflicts <- FALSE
suppressMessages(purrr::walk(packages, ~library(.x,
                                                character.only = TRUE,
                                                warn.conflicts = warn_conflicts)))


rm(packages, packages_base, packages_cran, packages_renv)
