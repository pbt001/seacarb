# Copyright (C) 2008 Jean-Pierre Gattuso and Heloise Lavigne and Aurelien Proye
# Revised by James Orr, 2012-01-17
#
# This file is part of seacarb.
#
# Seacarb is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or any later version.
#
# Seacarb is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with seacarb; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#
"K2p" <-
function(S=35,T=25,P=0,pHscale="T"){

nK <- max(length(S), length(T), length(P), length(pHscale))

##-------- Creation de vecteur pour toutes les entrees (si vectorielles)

if(length(S)!=nK){S <- rep(S[1], nK)}
if(length(T)!=nK){T <- rep(T[1], nK)}
if(length(P)!=nK){P <- rep(P[1], nK)}
if(length(pHscale)!=nK){pHscale <- rep(pHscale[1], nK)}
	
#-------Constantes----------------

#---- issues de equic----
tk = 273.15;           # [K] (for conversion [deg C] <-> [K])
TK = T + tk;           # T [C]; TK[K]

	# --------------------- Phosphoric acid ---------------------
	#
	#
	#   Guide to Best Practices in Ocean CO2 Measurements 2007 Chap 5 p 15  
	#  (Dickson and Goyet): pH_T, mol/(kg-soln)
	#  
	#
	#	*** J. Orr (15 Jan 2013): Formulation changed to be on the SWS scale (without later conversion)
	
	#lnK2P = -8814.715 / TK + 172.0883 - 27.927 * log(TK) + (-160.34 / TK + 1.3566) * sqrt(S) + (0.37335 / TK - 0.05778) * S;
	
	# From J. C. Orr on 15 Jan 2013:
	# The formulation above was a modified version of Millero (1995) where Dickson et al. (2007) subtracted 0.015
        # from Millero's original constant (172.1033) to give 172.0883 (the 2nd term above). BUT Dickson's reason for that 
        # operation was to "convert--approximately--from theSWS pH scale (including HF) used by Millero (1995) to the 'total' 
        # scale ...". 
        # This subtraction of 0.015 to switch from the SWS to Total scale is not good for 2 reasons:
        # (1) The 0.015 value is inexact (not constant), e.g., it is 0.022 at T=25, S=35, P=0;
	# (2) It makes no sense to switch to the Total scale when just below you switch back to the SWS scale.
        # The best solution is to reestablish the original equation (SWS scale) and delete the subsequent conversion

	# now the original formulation: Millero (1995)

	lnK2P = -8814.715 / TK + 172.1033 - 27.927 * log(TK) + (-160.34 / TK + 1.3566) * sqrt(S) + (0.37335 / TK - 0.05778) * S;

	K2P = exp(lnK2P);
	

# ---- Conversion from Total scale to seawater scale before pressure corrections
#      *** JCO: This is no longer necessary: with original formulation (Millero, 1995), K2P is on "seawater scale"!

#factor <- kconv(S=S, T=T, P=rep(0,nK))$ktotal2SWS
#K2P <- K2P * factor

# ----------------- Pressure Correction ------------------	
K2P <- Pcorrect(Kvalue=K2P, Ktype="K2p", T=T, S=S, P=P, pHscale="SWS")

###----------------pH scale corrections
factor <- rep(NA,nK)
pHsc <- rep(NA,nK)
for(i in (1:nK)){   
 if(pHscale[i]=="T"){factor[i] <- kconv(S=S[i], T=T[i], P=P[i])$kSWS2total ; pHsc[i] <- "total scale"}
 if(pHscale[i]=="F"){factor[i] <- kconv(S=S[i], T=T[i], P=P[i])$kSWS2free ; pHsc[i] <- "free scale"}
 if(pHscale[i]=="SWS"){factor[i] <- 1 ; pHsc[i] <- "seawater scale"}
K2P[i] <- K2P[i]*factor[i]
}

##------------Warnings

for(i in 1:nK){
if((T[i]>45)|(S[i]>45)|(T[i]<0)){warning("S and/or T is outside the range of validity of the formulation available for K2p in seacarb.")}
}

attr(K2P,"unit")     = "mol/kg-soln"
attr(K2P,"pH scale") = pHsc
return(K2P)
}
