
# This file is automatically generated, you probably don't want to edit this

jjbarstatsOptions <- if (requireNamespace('jmvcore')) R6::R6Class(
    "jjbarstatsOptions",
    inherit = jmvcore::Options,
    public = list(
        initialize = function(
            dep = NULL,
            group = NULL,
            grvar = NULL,
            excl = TRUE,
            originaltheme = FALSE, ...) {

            super$initialize(
                package='jjstatsplot',
                name='jjbarstats',
                requiresData=TRUE,
                ...)

            private$..dep <- jmvcore::OptionVariables$new(
                "dep",
                dep,
                suggested=list(
                    "ordinal",
                    "nominal"),
                permitted=list(
                    "factor"))
            private$..group <- jmvcore::OptionVariable$new(
                "group",
                group,
                suggested=list(
                    "ordinal",
                    "nominal"),
                permitted=list(
                    "factor"))
            private$..grvar <- jmvcore::OptionVariable$new(
                "grvar",
                grvar,
                suggested=list(
                    "ordinal",
                    "nominal"),
                permitted=list(
                    "factor"))
            private$..excl <- jmvcore::OptionBool$new(
                "excl",
                excl,
                default=TRUE)
            private$..originaltheme <- jmvcore::OptionBool$new(
                "originaltheme",
                originaltheme,
                default=FALSE)

            self$.addOption(private$..dep)
            self$.addOption(private$..group)
            self$.addOption(private$..grvar)
            self$.addOption(private$..excl)
            self$.addOption(private$..originaltheme)
        }),
    active = list(
        dep = function() private$..dep$value,
        group = function() private$..group$value,
        grvar = function() private$..grvar$value,
        excl = function() private$..excl$value,
        originaltheme = function() private$..originaltheme$value),
    private = list(
        ..dep = NA,
        ..group = NA,
        ..grvar = NA,
        ..excl = NA,
        ..originaltheme = NA)
)

jjbarstatsResults <- if (requireNamespace('jmvcore')) R6::R6Class(
    inherit = jmvcore::Group,
    active = list(
        todo = function() private$.items[["todo"]],
        plot2 = function() private$.items[["plot2"]],
        plot = function() private$.items[["plot"]]),
    private = list(),
    public=list(
        initialize=function(options) {
            super$initialize(
                options=options,
                name="",
                title="Bar Charts",
                refs=list(
                    "ggplot2",
                    "ggstatsplot"),
                clearWith=list(
                    "dep",
                    "group",
                    "grvar",
                    "direction",
                    "originaltheme"))
            self$add(jmvcore::Html$new(
                options=options,
                name="todo",
                title="To Do"))
            self$add(jmvcore::Image$new(
                options=options,
                name="plot2",
                title="`Bar Chart Splitted by {grvar}`",
                renderFun=".plot2",
                requiresData=TRUE,
                visible="(grvar)"))
            self$add(jmvcore::Image$new(
                options=options,
                name="plot",
                title="Bar Chart",
                renderFun=".plot",
                requiresData=TRUE))}))

jjbarstatsBase <- if (requireNamespace('jmvcore')) R6::R6Class(
    "jjbarstatsBase",
    inherit = jmvcore::Analysis,
    public = list(
        initialize = function(options, data=NULL, datasetId="", analysisId="", revision=0) {
            super$initialize(
                package = 'jjstatsplot',
                name = 'jjbarstats',
                version = c(1,0,0),
                options = options,
                results = jjbarstatsResults$new(options=options),
                data = data,
                datasetId = datasetId,
                analysisId = analysisId,
                revision = revision,
                pause = NULL,
                completeWhenFilled = FALSE,
                requiresMissings = FALSE)
        }))

#' Bar Charts
#'
#' 'Wrapper Function for ggstatsplot::ggbarstats and
#' ggstatsplot::grouped_ggbarstats to generate Bar Charts.'
#' 
#'
#' @examples
#' \dontrun{
#' # example will be added
#'}
#' @param data The data as a data frame.
#' @param dep .
#' @param group .
#' @param grvar .
#' @param excl .
#' @param originaltheme .
#' @return A results object containing:
#' \tabular{llllll}{
#'   \code{results$todo} \tab \tab \tab \tab \tab a html \cr
#'   \code{results$plot2} \tab \tab \tab \tab \tab an image \cr
#'   \code{results$plot} \tab \tab \tab \tab \tab an image \cr
#' }
#'
#' @export
jjbarstats <- function(
    data,
    dep,
    group,
    grvar,
    excl = TRUE,
    originaltheme = FALSE) {

    if ( ! requireNamespace('jmvcore'))
        stop('jjbarstats requires jmvcore to be installed (restart may be required)')

    if ( ! missing(dep)) dep <- jmvcore::resolveQuo(jmvcore::enquo(dep))
    if ( ! missing(group)) group <- jmvcore::resolveQuo(jmvcore::enquo(group))
    if ( ! missing(grvar)) grvar <- jmvcore::resolveQuo(jmvcore::enquo(grvar))
    if (missing(data))
        data <- jmvcore::marshalData(
            parent.frame(),
            `if`( ! missing(dep), dep, NULL),
            `if`( ! missing(group), group, NULL),
            `if`( ! missing(grvar), grvar, NULL))

    for (v in dep) if (v %in% names(data)) data[[v]] <- as.factor(data[[v]])
    for (v in group) if (v %in% names(data)) data[[v]] <- as.factor(data[[v]])
    for (v in grvar) if (v %in% names(data)) data[[v]] <- as.factor(data[[v]])

    options <- jjbarstatsOptions$new(
        dep = dep,
        group = group,
        grvar = grvar,
        excl = excl,
        originaltheme = originaltheme)

    analysis <- jjbarstatsClass$new(
        options = options,
        data = data)

    analysis$run()

    analysis$results
}
