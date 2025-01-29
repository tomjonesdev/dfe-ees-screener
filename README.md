# dfe-ees-screener

Proof of concept for dockerising an R Plumber API for the [DfE's data screener](https://github.com/dfe-analytical-services/eesyscreener).

## Running locally in VS Code

1. Download R binary (https://www.stats.bris.ac.uk/R/)
2. Download the [R Extension for VS Code](https://marketplace.visualstudio.com/items?itemName=REditorSupport.r), you may be prompted to download the `languageservice` to use R code locally. Alternatively you can use an R-specific IDE such as [RStudio](https://posit.co/download/rstudio-desktop/)
3. Open `server.R` click the Run button at the top of the file. Alternatively, open an R Terminal and paste the following commands:

```
library(plumber)
pr("screen_controller.R") %>%
pr_run(port = 8000)
```

4. Open up Postman/PowerShell/curl etc. to hit the endpoints:

```
GET localhost:8000/screen
POST localhost:8000/screen
```
> For the POST endpoint, `dataFile` and `metaFile` arguments should be submitted with a `form-data` request body. Example files can be found in the "example-data" folder

## Dependencies

You may need to enter `pak::lockfile_install` to install the dependencies locally before running the API.

If any additional dependencies are added, run the following command to update the lockfile before commiting changes.

```
pak::lockfile_create(pkg = c("plumber", "github::dfe-analytical-services/eesyscreener", "readr", "<additional dependency 1>", "<additional dependency 2>"))
```

## Testing

If the data and meta files supplied to the POST endpoint generate an error from `eesyscreener`, and you only want to generate a successful response for testing, replace the function call in `screen_Controller.R`:

```
result <- screen_files(req$body$dataFile$filename, req$body$metaFile$filename, req$body$dataFile, req$body$metaFile)
```

with

```
write.csv(example_data, "example_data.csv", row.names = FALSE)
write.csv(example_data.meta, "example_data.meta.csv", row.names = FALSE)
result <- screen_files("example_data.csv", "example_data.meta.csv", example_data, example_data.meta)
```
