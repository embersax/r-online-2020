# Regression Exercises

# If you don't have the penguins data package installed from previous exercises,
# uncomment the lines below and run them before proceeding

#install.packages("remotes")
#remotes::install_github("allisonhorst/palmerpenguins")

# load the data
library(palmerpenguins) 

data("penguins")

# Remember the variable names by printing the names
# Information on the variables: https://github.com/allisonhorst/palmerpenguins
names(penguins)


# We want to know: Can we predict/explain penguin body mass with the variables we have?

# Run a linear regression with body_mass_g as the dependent variable and 
# species, culmen_length_mm, culmen_depth_mm, flipper_length_mm, and sex as the independent variables
reg1 <- lm(___ ~ ___, data=penguins)

# Look at the results of the regression with the summary function
___(reg1)

# Notice in the summary output that obserations (rows) with missing data were automatically
# removed from the analysis

# Plot the regression object to see a series of diagnostic plots
plot(reg1)


# Fit overall is pretty good.  The model above made Adelie penguins the base case, 
# and generated other indicator variables for the other species and gender.  
# To make a separate intercept for each species instead, add a -1 to the 
# formula you ran before; summarize the results again
reg2 <- lm(___ ~ ___, data=penguins)

___(reg2)


# If we look at the coefficients for the two models, you can see the coefficients 
# for species were the only ones to change
reg1$coefficients
reg2$coefficients


# Now, maybe the combination of culmen length and depth also matters for body mass.
# So let's include an interaction term between the two culmen variables.
# Hint: multiple two variables together to include them indpendently in the model and 
# have an interaction term automatically generated
reg3 <- lm(___ ~ ___, data=penguins)

___(reg3)

# Looks like that is important.  

# Let's use our model to predict the body mass for a new penguin.
# To predict, we need a data frame with the same column names as our original data.
newdata <- data.frame(species="Adelie",
                      sex="FEMALE",
                      # set other variables to mean for Adelie penguins
                      flipper_length_mm=mean(penguins$flipper_length_mm[
                        penguins$species=="Adelie"], na.rm=TRUE),
                      culmen_length_mm=mean(penguins$culmen_length_mm[
                        penguins$species=="Adelie"], na.rm=TRUE),
                      culmen_depth_mm=mean(penguins$culmen_depth_mm[
                        penguins$species=="Adelie"], na.rm=TRUE))

# The predict function will automatically make the indicator and interaction variables for us.
# Hint: look at the help for predict.lm (what gets called since we have an lm model)
# to see the order of the arguments it expects
predict(___, ___)

# Is the predicted body mass in the range we might expect for Adelie penguins?
mean(penguins$body_mass_g[penguins$species=="Adelie"], na.rm=TRUE)


# What's the confidence interval on the prediction?
# We use the prediction interval type because we want to know the expected 
# range for the mass of a single pengin, not the variability in the 
# expected value of the mean mass of penguins with these characteristics
predict(reg3, newdata, interval="prediction")

