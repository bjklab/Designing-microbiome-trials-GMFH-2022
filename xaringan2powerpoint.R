#' from Garrick Aden-Buie
#' https://github.com/gadenbuie/xaringan2powerpoint

slides_html <- "designing_microbiome_trials_GMFH.html"

# "print" HTML to PDF
pagedown::chrome_print("designing_microbiome_trials_GMFH.html",
                       output = "designing_microbiome_trials_GMFH.pdf")

# how many pages?
pages <- pdftools::pdf_info("designing_microbiome_trials_GMFH.pdf")$pages

# set filenames
filenames <- sprintf("slides/slides_%02d.png", 1:pages)

# create slides/ and convert PDF to PNG files
dir.create("slides")
pdftools::pdf_convert("designing_microbiome_trials_GMFH.pdf", dpi = 300, filenames = filenames)

# Template for markdown containing slide images
slide_images <- glue::glue("
---

![]({filenames}){{width=100%, height=100%}}
  
")
slide_images <- paste(slide_images, collapse = "\n")

# R Markdown -> powerpoint presentation source
md <- glue::glue("
---
output: 
  powerpoint_presentation:
    reference_doc: blankslide16-9.pptx
---

{slide_images}
")

cat(md, file = "slides_powerpoint.Rmd")

# Render Rmd to powerpoint
rmarkdown::render("slides_powerpoint.Rmd")  ## powerpoint!
