
# This file is automatically generated, you probably don't want to edit this

jjhistostatsOptions <- if (requireNamespace('jmvcore')) R6::R6Class(
    "jjhistostatsOptions",
    inherit = jmvcore::Options,
    public = list(
        initialize = function(
            dep = NULL,
            grvar = NULL,
            excl = TRUE,
            typestatistics = "parametric", ...) {

            super$initialize(
                package='jjstatsplot',
                name='jjhistostats',
                requiresData=TRUE,
                ...)

            private$..dep <- jmvcore::OptionVariables$new(
                "dep",
                dep,
                suggested=list(
                    "continuous"),
                permitted=list(
                    "numeric"))
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
            private$..typestatistics <- jmvcore::OptionList$new(
                "typestatistics",
                typestatistics,
                options=list(
                    "parametric",
                    "robust",
                    "bayes"),
                default="parametric")

            self$.addOption(private$..dep)
            self$.addOption(private$..grvar)
            self$.addOption(private$..excl)
            self$.addOption(private$..typestatistics)
        }),
    active = list(
        dep = function() private$..dep$value,
        grvar = function() private$..grvar$value,
        excl = function() private$..excl$value,
        typestatistics = function() private$..typestatistics$value),
    private = list(
        ..dep = NA,
        ..grvar = NA,
        ..excl = NA,
        ..typestatistics = NA)
)

jjhistostatsResults <- if (requireNamespace('jmvcore')) R6::R6Class(
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
                title="Histogram",
                refs=list(
                    "ggplot2",
                    "ggstatsplot"),
                clearWith=list(
                    "dep",
                    "group",
                    "grvar",
                    "excl",
                    "originaltheme",
                    "typestatistics"))
            self$add(jmvcore::Html$new(
                options=options,
                name="todo",
                title="To Do"))
            self$add(jmvcore::Image$new(
                options=options,
                name="plot2",
                title="`Histogram Splitted by {grvar}`",
                width=800,
                height=600,
                renderFun=".plot2",
                requiresData=TRUE,
                visible="(grvar)"))
            self$add(jmvcore::Image$new(
                options=options,
                name="plot",
                title="Histogram",
                renderFun=".plot",
                requiresData=TRUE))}))

jjhistostatsBase <- if (requireNamespace('jmvcore')) R6::R6Class(
    "jjhistostatsBase",
    inherit = jmvcore::Analysis,
    public = list(
        initialize = function(options, data=NULL, datasetId="", analysisId="", revision=0) {
            super$initialize(
                package = 'jjstatsplot',
                name = 'jjhistostats',
                version = c(1,0,0),
                options = options,
                results = jjhistostatsResults$new(options=options),
                data = data,
                datasetId = datasetId,
                analysisId = analysisId,
                revision = revision,
                pause = NULL,
                completeWhenFilled = FALSE,
                requiresMissings = FALSE)
        }))

#' Histogram
#'
#' 
#'
#' @examples
#' \dontrun{
#' # example will be added
#'}
#' @param data The data as a data frame.
#' @param dep .
#' @param grvar .
#' @param excl .
#' @param typestatistics .
#' @return A results object containing:
#' \tabular{llllll}{
#'   \code{results$todo} \tab \tab \tab \tab \tab a html \cr
#'   \code{results$plot2} \tab \tab \tab \tab \tab an image \cr
#'   \code{results$plot} \tab \tab \tab \tab \tab an image \cr
#' }
#'
#' @export
jjhistostats <- function(
    data,
    dep,
    grvar,
    excl = TRUE,
    typestatistics = "parametric") {

    if ( ! requireNamespace('jmvcore'))
        stop('jjhistostats requires jmvcore to be installed (restart may be required)')

    if ( ! missing(dep)) dep <- jmvcore::resolveQuo(jmvcore::enquo(dep))
    if ( ! missing(grvar)) grvar <- jmvcore::resolveQuo(jmvcore::enquo(grvar))
    if (missing(data))
        data <- jmvcore::marshalData(
            parent.frame(),
            `if`( ! missing(dep), dep, NULL),
            `if`( ! missing(grvar), grvar, NULL))

    for (v in grvar) if (v %in% names(data)) data[[v]] <- as.factor(data[[v]])

    options <- jjhistostatsOptions$new(
        dep = dep,
        grvar = grvar,
        excl = excl,
        typestatistics = typestatistics)

    analysis <- jjhistostatsClass$new(
        options = options,
        data = data)

    analysis$run()

    analysis$results
}
