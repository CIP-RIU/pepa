#' Automatic report for a Randomized Complete Block Design (RCBD)
#'
#' Produces an automatic report for selected traits in an experiment with a RCBD.
#' @param traits The traits to analize.
#' @param geno The genotypes.
#' @param rep The replications.
#' @param data The name of the data frame.
#' @param maxp Maximum allowed proportion of missing values to estimate, default is 10\%.
#' @param title The title.
#' @param subtitle The subtitle.
#' @param author Author.
#' @param format The output file format for the report, \code{"html"} by default.
#' Other options are \code{"word"} and \code{"pdf"}.
#' @param server logical
#' @param server_dir_name directory name in the server
#' @param server_file_name  file name in the server, without extensions
#' @author Raul Eyzaguirre.
#' @details It fits a linear model for a RCBD and explains the results.
#'
#' Under the assumption of fixed effects an ANOVA table is computed with missing values
#' estimated up to a specified percentage (10\% by default). If the ANOVA results in
#' a significant value for genotypes then the Tukey HSD method for pairwise differences
#' is applied. Assumptions of the model are evaluated with residual plots.
#'
#' Under the assumption of random effects the model is estimated using REML and the
#' variance components are shown. Missing values are not estimated in this case.
#' @return It returns an explanation about the RCBD fitted model.
#' @examples
#' repo.rcbd(c("trw", "vw"), "geno", "rep", pjpz09)
#'
#' # With a small data set
#' temp <- pjpz09[1:18, ]
#' repo.rcbd(c("trw", "vw", "crw"), "geno", "rep", temp)
#' @import st4gi
#' @importFrom utils browseURL
#' @export

repo.rcbd <- function(traits, geno, rep, data, maxp = 0.1,
                      title = "Automatic report for a Randomized Complete Block Design (RCBD)",
                      subtitle = NULL,
                      author = "International Potato Center",
                      format = c("html", "word", "pdf"),
                      server = FALSE,
                      server_dir_name = "foo",
                      server_file_name = "foo2"


                      ) {

  format <- paste(match.arg(format), "_document", sep = "")
  dirfiles <- system.file(package = "pepa")


  server<- server

  if(!server){


      fileRmd <- paste(dirfiles, "/rmd/rcbd.Rmd", sep = "")
      fileURL <- paste(dirfiles, "/rmd/rcbd.html", sep = "")
      fileDOCX <- paste(dirfiles, "/rmd/rcbd.docx", sep = "")
      filePDF <- paste(dirfiles, "/rmd/rcbd.pdf", sep = "")

  }  else{

      dirfiles <-  server_dir_name

      fileRmd <-  paste0(dirfiles, "rcbd.Rmd")   #paste(dirfiles, "/rmd/crd.Rmd", sep = "")
      fileRmd_server_name <-  paste0(dirfiles,  server_file_name, ".Rmd") #r.arias

      #fileURL <- paste(dirfiles, "/rmd/crd.html", sep = "")
      fileDOCX <-  paste0(dirfiles, "rcbd.docx")
      fileDOCX_server_name <- paste0(dirfiles, server_file_name , ".docx")  #paste(dirfiles, "/rmd/crd.docx", sep = "")
      #filePDF <- paste(dirfiles, "/rmd/crd.pdf", sep = "")

  }



  rmarkdown::render(fileRmd, output_format = format,
                    params = list(traits = traits,
                                  geno = geno,
                                  rep = rep,
                                  data = data,
                                  maxp = maxp,
                                  title = title,
                                  subtitle = subtitle,
                                  author = author))


  if(server){
    file.copy(fileDOCX, fileDOCX_server_name, overwrite = TRUE)
  }

  if(!server){
    if(format == "html_document") try(browseURL(fileURL))
    if(format == "word_document") try(system(paste("open", fileDOCX)))
    if(format == "pdf_document")  try(system(paste("open", filePDF)))
  }
}
