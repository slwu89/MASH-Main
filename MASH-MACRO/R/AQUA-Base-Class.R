###############################################################################
#       ___
#      /   | ____ ___  ______ _
#     / /| |/ __ `/ / / / __ `/
#    / ___ / /_/ / /_/ / /_/ /
#   /_/  |_\__, /\__,_/\__,_/
#            /_/
#
#   MASH-MACRO
#   AquaPop Abstract Base Class Definition
#   MASH Team
#   November 2017
#
###############################################################################

###############################################################################
# Class Definition
###############################################################################

#' Aquatic Population Abstract Base Class Definition
#'
#' An abstract base class that specific aquatic ecology models will inherit from. This is not strictly necessary in the R6 object-oriented framework but it is intended
#' to mirror a C++ polymorphic implementation.
#'
#' @docType class
#' @format An \code{\link{R6Class}} generator object
#' @keywords R6 class
#'
#' @section **Constructor**:
#'  * The constructor (initialize) method must be overwritten by all inheriting classes.
#'
#' @section **Methods**:
#'  * oneDay_popDynamics: this method must be overwritten by all inheriting classes (pure virtual function in C++)
#'  * oneDay_addCohort: see \code{\link{oneDay_addCohort_AquaPop_Base}}
#'  * get_PatchPointer: see \code{\link{get_PatchPointer_AquaPop_Base}}
#'  * set_PatchPointer: see \code{\link{set_PatchPointer_AquaPop_Base}}
#'  * get_TilePointer: see \code{\link{get_TilePointer_AquaPop_Base}}
#'  * set_TilePointer: see \code{\link{set_TilePointer_AquaPop_Base}}
#'  * get_MosquitoPointer: see \code{\link{get_MosquitoPointer_AquaPop_Base}}
#'  * set_MosquitoPointer: see \code{\link{set_MosquitoPointer_AquaPop_Base}}
#'
#' @section **Fields**:
#'  * EggQ: set to \code{NULL} by default, not required by 'Emerge' model of aquatic ecology; see \code{\link[MASHcpp]{EggQ}}
#'  * ImagoQ: see \code{\link[MASHcpp]{ImagoQ}}
#'  * PatchPointer: a reference to a \code{\link{MacroPatch}} object
#'  * TilePointer: a reference to a \code{\link{MacroTile}} object
#'  * MosquitoPointer: a reference to an object inheriting from \code{\link{Mosquito_Base}}
#'
#' @md
#' @export
AquaPop_Base <- R6::R6Class(classname = "AquaPop_Base",
                 portable = TRUE,
                 cloneable = FALSE,
                 lock_class = FALSE,
                 lock_objects = FALSE,

                 # public methods & fields
                 public = list(

                   #################################################
                   # Constructor
                   #################################################

                   initialize = function(){
                     # C++: make this an actual constructor.
                     # don't forget a !virtual! destructor
                     cat("constructor for AquaPop_Base class should never be called\n")
                   },

                   oneDay_popDynamics = function(){
                     # C++: make this a virtual function
                     cat("oneDay_popDynamics for AquaPop_Base should never be called\n")
                   },

                   reset = function(){
                     # C++: make this a virtual function
                     # this resets the aquatic population between simulation runs
                     cat("oneDay_popDynamics for AquaPop_Base should never be called\n")
                   }

                  ),

                  # private methods & fields
                  private = list(

                    # Aquatic Populations
                    EggQ                      = NULL,
                    ImagoQ                    = NULL,

                    # Pointers
                    PatchPointer              = NULL

                  )

) #end class definition


###############################################################################
# Base Methods
###############################################################################

#' Add Emerging Cohort to Adult Population
#'
#' Take emerging aquatic stage mosquitoes from \code{\link[MASHcpp]{ImagoQ}} and add to the adult population.
#' This function interacts with all mosquito models that inherit from \code{\link{Mosquito_Base}}, and requires
#' those models to have a \code{get_emergingAdults} method defined.
#'
#'  * This method is bound to \code{AquaPop_Base$oneDay_addCohort}
#'
#' @param ix the patch ID passed down from the calling \code{\link{MacroPatch}} in \code{\link{oneDay_addCohort_Patch}}
#'
oneDay_addCohort_AquaPop_Base <- function(ix){
  EmergingAdults = private$ImagoQ$get_ImagoQTime(tNow = private$PatchPointer$get_TilePointer()$get_tNow(),clear = TRUE)

  if(length(EmergingAdults) > 0){
    for(i in 1:length(EmergingAdults)){
      private$PatchPointer$get_TilePointer()$get_MosquitoPointer()$get_emergingAdults(M=EmergingAdults[[i]]$N,ix=ix)
    }
  }
}

AquaPop_Base$set(which = "public",name = "oneDay_addCohort",
  value = oneDay_addCohort_AquaPop_Base, overwrite = TRUE
)


###############################################################################
# Getters & Setters
###############################################################################

#' Get Patch Pointer
#'
#' Return a pointer to the enclosing \code{\link{MacroPatch}}
#'
get_PatchPointer_AquaPop_Base <- function(){
  return(private$PatchPointer)
}

AquaPop_Base$set(which = "public",name = "get_PatchPointer",
  value = get_PatchPointer_AquaPop_Base, overwrite = TRUE
)

#' Set Patch Pointer
#'
#' Set a pointer to the enclosing \code{\link{MacroPatch}}
#'
#' @param PatchPointer a reference to \code{\link{MacroPatch}} object
#'
set_PatchPointer_AquaPop_Base <- function(PatchPointer){
  private$PatchPointer = PatchPointer
}

AquaPop_Base$set(which = "public",name = "set_PatchPointer",
  value = set_PatchPointer_AquaPop_Base, overwrite = TRUE
)

#' Get Egg Queue
#'
#' Returns a reference to the \code{\link[MASHcpp]{EggQ}}
#'
#'  * This method is bound to \code{AquaPop_Base$get_EggQ}
#'
get_EggQ_AquaPop_Base <- function(){
  return(private$EggQ)
}

AquaPop_Base$set(which = "public",name = "get_EggQ",
  value = get_EggQ_AquaPop_Base, overwrite = TRUE
)

#' Get Imago Queue
#'
#' Returns a reference to the \code{\link[MASHcpp]{ImagoQ}}
#'
#'  * This method is bound to \code{AquaPop_Base$get_ImagoQ}
#'
get_ImagoQ_AquaPop_Base <- function(){
  return(private$ImagoQ)
}

AquaPop_Base$set(which = "public",name = "get_ImagoQ",
  value = get_ImagoQ_AquaPop_Base, overwrite = TRUE
)
