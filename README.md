# An Environmental Study In A Forest Area
This code was created in the context of a data analysis course of a postgraduate program and concerns the environmental study in a forest area, in which a comparison between burned and non-forested areas is made.

The data are for a region of Portugal and can be found in P. Cortez and A. Morais. A Data Mining Approach to Predict Forest Fires using Meteorological Data. In J. Neves, M. F.
Santos and J. Machado Eds., New Trends in Artificial Intelligence, Proceedings of the 13th EPIA 2007 - Portuguese Conference on Artificial Intelligence, December, Guimaraes, Portugal, pp. 512-523, 2007.

The article is available at http://www3.dsi.uminho.pt/pcortez/fires.pdf. 

The environmental indicators included in the data are described in detail below according to the suggestion of the above article: 
1. X x-axis spatial coordinate within the Montesinho park map: 1 to 9
2. Y y-axis spatial coordinate within the Montesinho park map: 2 to 9
3. month month of the year: number from 1 to 12 corresponding from "jan" to "dec"
4. day day of the week: from 1 for Monday to 7 for Sunday
5. FFMC FFMC index from the FWI system: 18.7 to 96.20
6. DMC DMC index from the FWI system: 1.1 to 291.3
7. DC DC index from the FWI system: 7.9 to 860.6
8. ISI ISI index from the FWI system: 0.0 to 56.10
9. temp temperature in Celsius degrees: 2.2 to 33.30
10. RH relative humidity in %: 15.0 to 100
11. wind speed in km/h: 0.40 to 9.40
12. rain outside rain in mm/m2 : 0.0 to 6.4
13. area the burned area of the forest (in ha): 0.00 to 1090.84
(this output variable is very skewed towards 0.0, thus it may
make sense to model with the logarithm transform).
 
 
The first 6 questions are analysed in the development of the paper. First, the distribution of indicators (temperature, humidity, wind speed) between burnt and non-burnt areas is presented and compared, while at the same time
identify whether the sample comes from an already known distribution by means of a goodness-of-fit test X2. It is then tested whether the mean values of the indicators differ between burnt and non-burnt areas and the significance of the difference is examined. 
of each area by examining the statistical size of the median. The correlation of all the indicators by zone is then checked, and the dependence of temperature on wind speed is examined in detail 
and humidity in an attempt to fit initially linear models and then perhaps extend to nth degree polynomial models. Finally, the accuracy of the linear regression coefficient is investigated in the case where the dependence of
temperature dependence on humidity is linear by calculating and comparing the parametric and bootstrap confidence intervals. 