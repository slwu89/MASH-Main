################################################################################################################
# Bionomics Plotly Routines
# HMSC,SLW
################################################################################################################

###############################################################################
# Histograms
###############################################################################

# these functions take parameter 'data' which is raw JSON read back into R

bionomics_lifespan <- function(data){
  lifespans = vapply(X = data,FUN = function(x){
    x$bionomics_lifespan[[1]]
  },FUN.VALUE = numeric(1),USE.NAMES = FALSE)
  return(lifespans)
}

bionomics_BMinterval <- function(data){
  BMintervals = vapply(X = data,FUN = function(x){
    if(x$bionomics_bmInt[[1]]>0){
      return(x$bionomics_bmInt[[1]])  
    } else {
      return(NaN) 
    }
  },FUN.VALUE = numeric(1),USE.NAMES = FALSE)
  BMintervals = Filter(Negate(is.nan),BMintervals)
  return(BMintervals)
}

bionomics_HumanBMinterval <- function(data){
  HumanBMintervals = vapply(X = data,FUN = function(x){
    if(x$bionomics_bmIntH[[1]]>0){
      return(x$bionomics_bmIntH[[1]])
    } else {
      return(NaN)
    }
  },FUN.VALUE = numeric(1),USE.NAMES = FALSE)
  HumanBMintervals = Filter(Negate(is.nan),HumanBMintervals)
  return(HumanBMintervals)
}

bionomics_HumanBM <- function(data){
  HumanBM = vapply(X = data,FUN = function(x){
    x$feedHumanH[[1]]
  },FUN.VALUE = numeric(1),USE.NAMES = FALSE)
  return(HumanBM)
}

bionomics_vc <- function(data, eip=10){
  vc = vapply(X = data,FUN = function(x,eip){
    feedT = unlist(x$feedAllT)
    if(length(feedT)<2 | is.null(feedT)){
      return(NaN)
    } else {
      if((diff(feedT)>eip)[1]){
        # sum all pairs of bites that are more than EIP days apart
        sum(apply(X = combn(feedT,2),MARGIN = 2,FUN = function(x){
          diff(x)>eip
        }))
      } else {
        return(NaN)
      }
    }
  },FUN.VALUE = numeric(1),eip = eip,USE.NAMES = FALSE)
  vc = Filter(Negate(is.nan),vc)
  return(vc)
}

# HMSC plotly histogram
histogramPlotLyGenericBionomics=function(data,title,color){
  p=plot_ly(x=data,name=title,marker=list(color=color),type="histogram") %>%
    layout(
      barmode="overlay",
      legend=list(x=1.05,y=.5,bgcolor="#FFFFFF"),
      title=paste(title, "( Mean: ",signif(mean(data),3),")"),
      bargap=0.1
    )
  p
}


###############################################################################
# Chord diagram
###############################################################################


# oneHistory: a single mosquito's JSON outfile
transitionsInMosquitoStates <- function(oneHistory, stateSpace = c("D","M","F","B","R","L","O","S","E")){
  states = oneHistory$stateH
  createSequenceMatrix(stringchar = unlist(states[-1]),possibleStates = stateSpace)
}

transitionsInMosquitoPopulation <- function(popHistory, stateSpace = c("D","M","F","B","R","L","O","S","E")){
  transMatrices = lapply(X = popHistory,FUN = transitionsInMosquitoStates)
  transitions = Reduce(f = "+",x = transMatrices)
  transitions[stateSpace,stateSpace]
}

circlizeStatesTransitionMatrix <- function(history, stateSpace = c("D","M","F","B","R","L","O","S","E")){
  transitions=transitionsInMosquitoPopulation(history,stateSpace=stateSpace)
  colors=c("#555555","#95E455","pink","red","purple","cyan","blue","yellow","grey")
  chordDiagramFromMatrix(transitions,directional=1,grid.col=colors,direction.type="arrows",self.link=2)
}
