FromWanyiNov-perturbedhivevalidation
====================================

Makes pics on pg 118 of thesis
This is code that Wanyi emailed me that she said she used to do the weight validations.
It looks as if this is true for the perturbed hives- because when you run this code with dimethoate and fungicide parameters,
you get pictures on pg 118.

The problem is that this code uses the old interp2 function, which causes a jump discontinuity in April. 
Furthermore, for the case when we put healthy parameters in this version of the model, honey fills up the entire hive 
(there are no space limitations for egg laying here), so we get 500,000 cells of honey in April,
 which amounts to 250 kg of honey. (1 cell = .5 g)
