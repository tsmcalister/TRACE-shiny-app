#load(file='/Users/timothy/Projects/Trade-Manipulation-in-Corporate-Bond-Markets/new_app/data/trace-shiny.data')

#file is named trace
load(file='/Users/timothy/Projects/Trade-Manipulation-in-Corporate-Bond-Markets/new_app/data/trace-day.data')

getNumericVariables <- function(data)
{
  labels <- names(data)
  result <- c()
  
  for(i in 1:length(labels))
  {
    if(is.numeric(data[,labels[i]]))
    {
      result <- c(result, labels[i])
    }
  }
  return(result)
}

getCategoricalVariables <- function(data)
{
  labels <- names(data)
  result <- c()
  
  for(i in 1:length(labels))
  {
    if(is.character(data[,labels[i]]) || is.logical(data[,labels[i]]))
    {
      result <- c(result, labels[i])
    }
  }
  return(result)
}