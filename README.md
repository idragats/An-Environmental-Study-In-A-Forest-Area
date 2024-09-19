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

# Distribution Checks: Normal, Poisson, and Chi-Square(X²)
In this table we can see the results of chi-square goodness-of-fit test for both distributions, 
normal and Poisson. the values of variable h show us if it approaches (h=0) or it doesn' t approach (h=1), each of distributions 

![image](https://github.com/user-attachments/assets/3966456d-eb46-4251-a658-f18b6a56a4a1)

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/4d9a305c-d0da-461d-877c-e2ee2bb38d37" width=500 height=480></td>
    <td><img src="https://github.com/user-attachments/assets/81d2b610-432a-49e8-8685-60a65572fe70" width=500 height=480></td>
  </tr>
</table>

<table>
 <tr>
   <td><img src="https://github.com/user-attachments/assets/ac901325-55a1-48b7-94b3-532a725b0784" width=500 height=480></td>
   <td><img src="https://github.com/user-attachments/assets/faf1ec1c-bc3c-4aa3-a0ab-61bde89fcb30" width=500 height=480></td>
 </tr>
</table>
 
<table> 
 <tr>
  <td><img src="https://github.com/user-attachments/assets/a453b632-dee6-4fbb-800c-00955d3cb0ae" width=500 height=480></td>
   <td><img src="https://github.com/user-attachments/assets/19be8dd4-5768-4ffd-9715-046f651a9d07" width=500 height=480></td>     
 </tr>
</table>

the average of the temperature in unburnt area is : mu=18.427935 Celsius the average of the temperature in burnt area is : mu=19.311111 Celcius the difference of the average of the temperature between burnt area and unburnt area  is : dmu=0.883176 Celsius 
we could see that the temperature of the burnt area is slightly higher value from unburnt area and specifically is : 0.883176  Celcius

the average of the relative humidity in unburnt area is : mu=44.894737 the average of the relative humidity in burnt area is : mu=43.733333 the difference of the average terms of the relative humidity between burnt area and unburnt area is dmu=1.161404 percentage 
we could see also, that the relative humidity of the burnt area is slightly higher value from unburnt area and it's 1.161404 ha exactly 

the average of the wind speed in unburnt area is : mu=3.913360 Km/h the average of the wind speed in burnt area is : mu=4.112963 Km/h the difference of the average terms of the wind speed  between burnt area and unburnt area  is dmu=0.199603 Km/h fianlly we could see that the wind speed of the burnt area is also, slightly higher value from unburnt area  and it's 0.199603 Km/h exactly.

# Calculating and Interpreting the 95% Confidence Interval

In the table below we could see the 95between burnt and unburnt areas, h value and p value for every index.

![image](https://github.com/user-attachments/assets/eec9e740-6cb1-4323-85ff-73d34f45350b)

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/4d0ad0d7-6791-483e-8502-f3414bd3d437" width=600 height=300></td>
    <td><img src="https://github.com/user-attachments/assets/4b02eb9a-4d7e-482f-867f-6fbe42e23399" width=600 height=300></td>
    <td><img src="https://github.com/user-attachments/assets/0df55528-b460-40db-b1c0-9bd088f63de2" width=600 height=300></td>
  </tr>
</table>  

# Analysis of T, RH, WS Using 1000 and 50 Samples 
we could see if the null hypothesis can be accetable or not. for this reason we can apply the below test. for M=50 random samples from n=20 observation and we calculate the percentage that this reject the null hypothesis under of 95

50 samples for the temperature index T
the null hypothesis for temperature index can be accepted at the percentage 86.000000 

50 samples for the relative humidity index
the null hypothesis for relative humidity index can be accepted at the percentage 94.000000 

50 samples for the wind speed 
the null hypothesis for wind speed index can be accepted at the percentage 94.000000 

we could see that the null hypothesis can accepted for big sample groups. After the calculating test and sampling with  M=50, the null hypothesis can be accepted under of 95 the probability that can be accepted the null hypothesis for every index 
is bigest from level of significance 

the 1000 samples for the temperature index T
the percentage that can be accepted null hypothesis of 1000 samples
for temperature index is 100.000000

the 1000 samples for the index RH
the percentage that can be accepted null hypothesis of 1000 samples
for relative humidity index is 100.000000

the 1000 samples for the index WIND
the percentage that can be accepted null hypothesis of 1000 samples
for wind speed index is 100.000000

the 50 samples for the temperature index T
the percentage that can be accepted null hypothesis of 50 samples
for temperature index is 95.940000

the 50 samples for the index RH
the percentage that can be accepted null hypothesis of 50 samples
for relative humidity index is 95.960000

the 50 samples for the index WIND
the percentage that can be accepted null hypothesis of 50 samples
for wind speed index is 96.120000

Therefore, using the two standardisation tests we observe that the second has higher validity than the first due to sample size.
However, at the 95 which means that the null hypothesis for those medians burnt and unburnt areas is accepted at the 95.
This means that temperature, relative humidity and wind speed are no more significant in one area than they are in the other, 
i.e. burnt and unburnt areas. There is no dramatic change in any of the three indicators in the two different regions

# Correlation Analysis and Student's t-Tests
![image](https://github.com/user-attachments/assets/8102c145-6aca-42f0-9bca-12d5246c4ac7)       ![image](https://github.com/user-attachments/assets/894f1915-e24f-4de5-8ec3-b79d2dba754d)

![image](https://github.com/user-attachments/assets/bcf0cf5d-af77-4a8c-8c3b-cd548521e062)       ![image](https://github.com/user-attachments/assets/df4bb93d-e176-4a6a-bb91-6f05abc58367)

![image](https://github.com/user-attachments/assets/d7660cb6-c998-4038-9864-ceb1dde3ca72)       ![image](https://github.com/user-attachments/assets/10dd15e3-4e17-4889-a6a7-799d5d6921f0)

![image](https://github.com/user-attachments/assets/dea23bb1-ddda-448c-9007-149211a8359c)       ![image](https://github.com/user-attachments/assets/742c6d14-2fa8-4543-b24b-73019b05020d)

![image](https://github.com/user-attachments/assets/8214179c-6d2e-4516-8f37-b30590bcd6a4)       ![image](https://github.com/user-attachments/assets/a0272dea-3590-49a2-b028-82cfdadcf9b6)

![image](https://github.com/user-attachments/assets/9d593e80-4a19-4bf1-9c8f-9ad5f198be88)       ![image](https://github.com/user-attachments/assets/18dd69e3-5c06-46f9-865c-07acc7042fa5)

![image](https://github.com/user-attachments/assets/7bcdf4e6-f50f-43b3-88ab-9ffd60bf1c52)       ![image](https://github.com/user-attachments/assets/303f6764-d4ed-45fc-9a47-04a66af5c561)

After first test, we could see that the indexes which correlated are : FFMC and ISI, DC and DMC,  ISI and T, T and RH 

To control if the indexex correlated after sampling test, we used  tcrit =2.024394e+00 if it could find between tlower and tupper

# Data Fitting, Standard Errors, and Coefficient of Determination

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/1733fc53-0d1c-4329-8122-d5aa232b5296" width=600 height=300></td>
    <td><img src="https://github.com/user-attachments/assets/8293335f-dccd-4141-8618-66f564cf3781" width=600 height=300></td>
  </tr>
</table>  

<table> 
 <tr>
    <td><img src="https://github.com/user-attachments/assets/4fe1243a-4eb2-4df0-9352-06d33caf01d8" width=600 height=300></td>
    <td><img src="https://github.com/user-attachments/assets/61295436-e83b-4dcb-beb2-e28163540b9e" width=600 height=300></td>
  </tr>
</table>  

The coefficient of determination for the index RH of the linear regression model to the index T is 2.616197
The adjusted coefficient of determination for the linear model from index RH to the index T is -0.054991

The coefficient of determination for the index WIND of the linear regression model to the index T is 0.313498
The adjusted coefficient of determination for the linear model from index WIND to the index T is  -0.079937

Both of models, RH to T and WIND to T, are similar about the correlation indexes and the estimates errors, which means  that both of cases, the indexes are not uncorrelated. 
finally, the extra application of the polynomial model doesn' t make sence, because the effort to find a polynomial model until 4th degree has as a result the adjusted coefficient of determination to be stable around zero value


# Parametric Tests and Bootstrap Methods

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/e4262f77-2848-4eb7-a574-5ce6ee9b8046" width=600 height=300></td>
    <td><img src="https://github.com/user-attachments/assets/e3c0d597-f566-4608-bf9b-2a1c63e42e69" width=600 height=300></td>
  </tr>
</table>  

The coefficient â from the group of sample is: â=-0.187674
The percentage of appearance from parametric test is: 7.000000 percentage
The percentage of appearance from  bootstrap test is : 20.000000 percentage

we could see the differences between of 2 tests, parametric and bootstrap. The result of distribution about the b coefficient of the parametric test shows us a narrow distribution. 
However the result of distribution about the b coefficient of the bootstrap test shows us a wide distribution as a final result, we can have a better assessments about accuracy of the b coefficient from bootstrap test


