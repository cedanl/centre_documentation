
# Configure base packages, because we load all packages from .Rprofile
packages_base <- rownames(installed.packages(priority = "base"))

# Set packages in order of load
packages_cran <- c(
  "renv",
  "knitr",
  "quarto",
  "purrr",
  "lintr"
)

## Combine packages
packages <- c(packages_base, packages_cran)
packages_renv <- c(packages_cran)


# Configure renv
options(renv.snapshot.filter = function(project) {

  #'*INFO* renv only puts imports in the lockfile, not suggests. Here is some code to include
  # this as well if necessary. One could also add more packages directly to packages_cran
  # Use purrr to apply the function to each package and combine the results
  # imports_list <- purrr::map(packages_renv,
  #                           ~tools::package_dependencies(.x, which = c("Suggests"))
  # )
  # imports_vec <- unlist(imports_list)
  #
  # # Combine the original packages and the suggests, ensuring uniqueness
  # combined_packages <- unique(c(packages_renv, imports_vec))

  combined_packages <- packages_renv

  return(combined_packages)
})

renv::snapshot(type = "custom")

renv::restore()


# Load packages
# TODO Set to TRUE when adding packages to check if there are problematic conflicts
warn_conflicts <- FALSE
suppressMessages(purrr::walk(packages, ~library(.x,
                                                character.only = TRUE,
                                                warn.conflicts = warn_conflicts)))


rm(packages, packages_base, packages_cran, packages_renv, warn_conflicts)
