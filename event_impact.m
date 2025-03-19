function [zeroCrossing,isTerminal,direction] = event_impact(t,Z,params)
Z_nadir = calcNadirHeight(Z,params);
zeroCrossing = Z_nadir;
isTerminal = 1;
direction = -1;