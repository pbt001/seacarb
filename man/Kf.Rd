\encoding{latin1}
\name{Kf}
\alias{Kf}

\title{Equilibrium constant of hydrogen fluoride (mol/kg)}
\description{Stability constant of hydrogen fluoride (mol/kg)}
\usage{
Kf(S = 35, T = 25, P = 0, kf = "x", pHscale="T")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{S}{Salinity, default is 35}
  \item{T}{Temperature in degrees Celsius, default is 25oC}
  \item{P}{Hydrostatic pressure in bar (surface = 0), default is 0}
  \item{kf}{"pf" for using Kf from Perez and Fraga (1987) "dg" for using Kf from Dickson and Riley (1979 in Dickson and Goyet, 1994), default is "pf". Attention do not use a vector for this argument.}
  \item{pHscale}{choice of pH scale: "T" for the total scale, "F" for the free scale and "SWS" for using the seawater scale, default is "T" (total scale)}
}

\details{
The Perez and Fraga (1987) constant is recommended by Guide to Best Practices for Ocean CO2 Measurements (2007). The Dickson and Riley (1979 in Dickson and Goyet, 1994) constant is recommended by DOE (1994). 

It is, however, critical to consider that each formulation is only valid for specific ranges of temperature and salinity:
 
\itemize{
\item Perez and Fraga (1987): S ranging between 10 and 40 and T ranging between 9 and 33oC.

\item Dickson and Riley (1979 in Dickson and Goyet, 1994): S ranging between 0 and 45 and T ranging between 0 and 45oC.
}

Note that the formulation chosen here for kf will be used by default in kconv. Then, it is recommended to set this formulation at the beginning of the R session. The kf formulation is retained as a global variable named "kfg", hence it is not possible to use a variable named "kfg" in the R environment.

Note that the arguments can be given as a unique number or as vectors (except for kf). If the lengths of the vectors are different, the longer vector is retained and only the first value of the other vectors is used. It can therefore be critical to use vectors of the same length. 

The pressure correction was applied on the free scale. The formulation of Dickson and Riley (1979 in Dickson and Goyet, 1994) provides Kf on the free scale but that of Perez and Fraga (1987) provides it on the total scale. Hence, in that case, Kf was first transformed from the total scale to the free scale. With both formulations, the pressure correction was applied as described by Millero (1995), and the value was transformed back to the required scale (T, F or SWS).
} 

\value{
  \item{Kf}{Stability constant of hydrogen fluoride (mol/kg)}

}
\references{
Dickson A. G. and Riley J. P., 1979 The estimation of acid dissociation constants in seawater media from potentiometric titrations with strong base. I. The ionic product of water. \emph{Marine Chemistry} \bold{7}, 89-99.

Dickson A. G., Sabine C. L. and Christian J. R., 2007 Guide to best practices for ocean CO2 measurements. \emph{PICES Special Publication} \bold{3}, 1-191.

DOE 1994 \emph{Handbook of methods for the analysis of the various parameters of the carbon dioxide system in sea water}. ORNL/CDIAC-74. Oak Ridge,Tenn.: Carbon Dioxide Information Analysis Center, Oak Ridge National Laboratory.

Millero F. J., 1995 Thermodynamics of the carbon dioxide system in the oceans. \emph{Geochimica Cosmochimica Acta} \bold{59}: 661-677.

Perez F. F. and Fraga F., 1987 Association constant of fluoride and hydrogen ions in seawater. \emph{Marine Chemistry} \bold{21}, 161-168.
}

\author{
Heloise Lavigne, Aurelien Proye and Jean-Pierre Gattuso \email{gattuso@obs-vlfr.fr}
}


\examples{
  Kf(S=35,T=25,P=0,kf="pf",pHscale="T")
}
\keyword{utilities}
