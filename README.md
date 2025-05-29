# Set up Neovim for data science

This sets up Neovim for use with, primarily R, but also Python and Julia. Also for writing in markdown.

# Install

Clone the repo, or copy its contents, to your own `~/.config/nvim` folder.

Open Neovim and let it install all the plugins.

NOTE: The image support for markdown files is set up for the kitty terminal using imagemagick. The configuration for the "image.nvim" plugin is in the file `4-markdown.lua`. You need to have imagemagick installed on your system for this to work.

# Dependencies

## System level

`R` programming language

`quarto` [optional]

`air` R formatter [optional]

`stylua` lua formatter (for the nvim config) [optional]

`imagemagick` for image support inside markdown files [optional]

`vd` Visidata terminal spreadsheets program

## R packages

`{languageserver}`, `{collapse}`, `{rio}`, `{httpgd}` [optional], `{reactable}` [optional], `{colorout}` [optional]


# Setting up Visidata for use from inside Neovim

Visidata (vd) is a powerful terminal-based spreadsheets program. 

1. Install Visidata: <https://www.visidata.org/install/>
2. [optional] Choose a better looking theme for Visidata: copy the file `visidata/config.py` to your own `~/.config/visidata/config.py`. (You'll probably have to make the folder `.config/visidata`.)
3. Add the functions `vd_view()` and `vd_summary()` from the Rprofile file to your own `.Rprofile`. Neovim is set up to use these functions for specific keybindings (see below).
4. Set the variable `.my_terminal` inside your `.Rprofile` to be the terminal of your choice. It is currently set to kitty new tab.

This allows you to have a nice terminal viewer for the R dataframes, and also to generate a quick summary of a dataframe (also useful as a variable explorer, if you have data with many variables). 


# Use

Open an R file (or an Rmd or quarto file) with Neovim. 

Start up the R session: `\rf`.

Set the current directory to the directory of the current file: `\rd` (This is only necessary if you've opened the file from a different location, and you want to import data or source files using relative paths. If you open Neovim from the root of your project's directory, the directory will already be set properly.)

Send commands from the R script to the R console with `<enter>` in Normal/Visual modes or with `<C-enter>` in insert mode. 

The base-R pipe: `<C-S-m>`. 

The assignment operators: `<-` is `<C-S-,>` and `->` is `<C-S-.>`. 

Even if you close the console pane (`<C-q>`), the R console will still be running. You can always get it back with `\rf`. You can continue to send commands to the console even when it's not visible. To actually quit the R session: `\rq` (does not save the environment).

Send a command from the script, and post the output of the command as a comment inside the script: `\o`. In Insert mode it is `<C-S-enter>`. If you want to do this multiple times, use the undo (`u`) after each run. (An important limitation is that this command will not create new R objects.)

Move the console to its own tab, such that you have the full screen for your script, and also the full screen for the console: while your cursor is in the terminal, normal mode, `<C-w>T` (the `<C-w>` shortcut is the general opening for all window management actions). To quickly switch between the console tab and the scripts tab: `<C-t>`. List all the tabs in Telescope: `<space-t>`. 

Toggle the file explorer: `<C-n>`

Toggle the Object Browser: `\ro`. Inside the Object Browser:

- `<enter>` on a dataframe shows its variables and the variable labels (similar to the variable explorer in Stata). 
- `<enter>` opens lists in the same way. 
- Search among objects, variables, and variable labels: `/`
- Actions inside the Object Browser (these call R functions for the object under the cursor, be it dataframe, variable, list, etc.): `s` summary, `v` Visidata view, `c` class, `g` glimpse, `h` head, `t` tail, `u` unique. 
- The Object Browser can also be used to see the list of loaded packages. `<enter>` on a package shows all the functions inside the package. `F1` on a function opens the help documentation in a new buffer. 

Use `<C-arrows>` to move between script pane, console pane, file explorer, and object browser.

Get quick help in a pop-up: `K` while cursor is on the name an R function. 

Open the full documentation for a function in its own buffer: `F1` while cursor is on the name an R function (works both in Normal and Insert mode).

For functions from packages, the documentation is available only after loading the package.

Show diagnostics for warnings and errors caught by the LSP: `<space>?`

Open the definition of a function in a separate buffer: `gd`. This works not just on your own functions, but for all functions from all R packages.

View a dataframe in Visidata: `\dv` while the cursor is on the name of the dataframe.

View the summary of a dataframe in Visidata: `\ds` while the cursor is on the name of the dataframe. The sample `Rprofile` also includes a `data_summary` function which opens the summary as an interactive table in a browser window. Either of these can be used as a more advanced variable explorer than the built in Object Browser.

Glimpse data (in the R console): `\dg` while cursor is on the name of the dataframe.

Search for text in current file: `<space>/`

Search for text in current project (grep): `<space>g`

List document symbols (includes sections defined with comments with trailing "----"): `<space>ds`. 

List TODOs (in entire project): `<space>dd`. The following TODOs comments are recognized: TODO, WARN, NOTE, HACK, PERF (PERFORMANCE), SEC (SECTION), TEST.

List all opened files (buffers): `<space>b`. Quickly switch between open buffers (shown in the tab-bar): `<A-arrows>`

Search files in current project: `<space>f`

Recently opened files: `<space>o`

Expand selection to broader semantic categories: `<C-space>`. Contract back the selection: `<C-S-space>`.

Treesitter is setup to recognize the following semantic categories:

- assignment (`=`, `<-`, `->`): shortcut: `=`
- left of the assignment: shortcut: `l=`
- right of the assignment: shortcut: `r=`
- function: shortcut: `f`
- function argument: shortcut: `a`
- class: shortcut: `c`

These can be used together with vim motions and with inner (`i`) or around (`a`). For instance, to delete an argument while leaving the comma do `dia`, delete the argument _and_ the comma do `daa`. Select a function: `vaf` (visual around function) or `vif` (visual inside function). Change the name of a variable: `cl=` (change left of assignment). Etc.

Swap around the arguments of a function (switch the order in which they appear): `<space>a` or `<space>A`

# Basic usage of Visidata

You can see all the options by looking through its menu. But here are some non-obvious options that are highly useful:

Quit Visidata: `q`

Expand the column width to see its full contents (useful for long text): `_`

Copy to clipboard the contents of a cell: `zY`

Search for text in the current column: `/`. Next search result: `n`. Previous search result: `N`.

Search for text in the current column _and_ select the all rows with positive hits: `|`

Open a new sheet containing only the selected rows: `"`

Steps `|` and `"` are useful when opening a summary table of a dataframe with a very large number of variables: first search inside the Label column for what you want, and then open the sheet that contains only what you searched for. Also useful when, e.g, sifting through World Bank search results as produced by `WDI::WDISearch("what I'm looking for")`.

Before sorting a numeric column, specify that it's numbers: integer `#` or numeric (float) `%`. 

Sort: descending `]`, ascending `[`.

Visidata can do many things on its own, but it is written in Python, and, as such, it is much slower than what you can achieve in R with the `{tidyverse}`, `{data.table}` or `{collapse}`.

# Using this configuration for Python, Julia, etc.

You can open a REPL using the "iron.nvim" plugin. The currently set shortcuts are under `\i`.

Another option would be to install the "molten" plugin.

# Customizing it to your own needs

Most keybindings are in the file `keybindings.lua`, and organized into sections by different categories. Some keybindings related to R are in the `5-r.lua` file.

If you dislike the automatic R formatter on save, comment out the line `r = { "air" }` in the `7-lsp-general.lua` file (part of the config for the "conform.nvim" plugin).
