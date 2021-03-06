PfPedigree <- R6Class("PfPedigree",
                      
                      public = list(
                        initialize = function(){
                          private$nAntigenLoci = 9
                          private$nptypes = c(3,5,4,3,6,3,2,7,9)
                          private$PedLength = 0
                          private$pfid = 1
                        },
                        
                        add2Pedigree = function(pf){
                          pfid = pf$get_pfid()
                          private$gtype[[pfid]] = pf$get_gtype()
                          private$ptype[[pfid]] = pf$get_ptype()
                          private$mic[[pfid]] = pf$get_mic()
                          private$mac[[pfid]] = pf$get_mac()
                          private$PedLength = private$PedLength+1
                        },
                          
                        get_PedLength = function(){
                          private$PedLength
                        },
                        
                        get_gtype = function(pfid){
                          private$gtype[[pfid]]
                        },
                        
                        get_ptype = function(pfid){
                          private$ptype[[pfid]]
                        },
                        
                        get_mic = function(pfid){
                          private$mic[[pfid]]
                        },
                        
                        get_mac = function(pfid){
                          private$mac[[pfid]]
                        },
                        
                        get_th = function(pfid){
                          private$th[[pfid]]
                        },
                        
                        set_th = function(pfid,thnew){
                          private$th[[pfid]] = thnew
                        },
                        
                        get_thEnd = function(pfid){
                          private$thEnd[[pfid]]
                        },
                        
                        set_thEnd = function(pfid,thEndnew){
                          private$thEnd[[pfid]] = thEndnew
                        },
                        
                        get_sib = function(pfid){
                          private$sib[[pfid]]
                        },
                        
                        get_nAntigenLoci = function(){
                          private$nAntigenLoci
                        },
                        
                        get_nptypes = function(){
                          private$nptypes
                        },
                        
                        get_pfid = function(){
                          private$pfid
                        },
                        
                        increment_pfid = function(){
                          private$pfid = private$pfid+1
                        }
                      ),
                      
                      private = list(
                        
                        PedLength = integer(0),
                        pfid = integer(0),
                        gtype = list(),
                        ptype = list(),
                        mic = list(),
                        mac = list(),
                        th = list(),
                        thEnd = list(),
                        ixh = list(),
                        tm = list(),
                        tmEnd = list(),
                        ixm = list(),
                        sib = list(),
                        nAntigenLoci = integer(0),
                        nptypes = NULL
                        
                      )
)