//
//  Constants.swift
//  NationData
//
//  Created by Christopher Inegbedion on 02/08/2024.
//

import Foundation

struct Constants {
    static let economicDataPoints = [
        "GDP",                    // Gross Domestic Product
        "GDP per capita",         // GDP per person
        "Inflation rate",         // Percentage increase in prices
        "Unemployment rate",      // Percentage of the labor force unemployed
        "Foreign direct investment (FDI)", // Investments made by foreign entities
        "Government debt",        // Total amount of public debt
        "Government budget balance", // Difference between government revenue and expenditure
        "Currency exchange rate", // Value of the country's currency against others
        "Interest rates",         // Cost of borrowing money
        "Export volume",          // Total value of exports
        "Import volume",          // Total value of imports
        "Trade balance",          // Difference between export and import volumes
        "Military expenditure",   // Total military expenditure as a percentage of GDP
        "Education expenditure",  // Total education expenditure as a percentage of GDP
        "Health expenditure",     // Total health expenditure as a percentage of GDP
        "Average household income",// Mean income of households
        "Ease of doing business index" // Ease of setting up and running a business
    ]
    static let socialDataPoints = [
        "Population",             // Total number of people
        "Population growth rate", // Annual percentage increase in population
        "Life expectancy",        // Average lifespan of a population
        "Literacy rate",          // Percentage of people who can read and write
        "Human Development Index (HDI)", // Composite statistic of life expectancy, education, and per capita income
        "Poverty rate",           // Percentage of the population below the poverty line
        "Birth rate",             // Number of births per 1,000 people per year
        "Death rate",             // Number of deaths per 1,000 people per year
        "Fertility rate",         // Average number of children born per woman
        "Median age",             // Age at which half the population is older and half is younger
        "Child mortality rate",   // Number of deaths of children under age five per 1,000 live births
        "Obesity rate",           // Percentage of the population classified as obese
        "Corruption perception index", // Perceived levels of public sector corruption
        "Gender inequality index", // Measure of gender disparities
        "Crime rate",              // Incidence of crime
        "Tourism arrivals",        // Number of international tourist arrivals
        "Public transport usage"   // Percentage of the population using public transport
    ]
    static let environmentalDataPoints = [
        "Renewable energy consumption", // Percentage of energy consumption from renewable sources
        "CO2 emissions per capita",     // Carbon dioxide emissions per person
        "Forest area",                  // Percentage of total land area covered by forests
        "Access to clean water",        // Percentage of the population with access to safe drinking water
        "Sanitation facilities"         // Percentage of the population with access to improved sanitation
    ]
    static let technologicalDataPoints = [
        "Internet penetration",         // Percentage of population with access to the internet
        "Telecommunication infrastructure", // Quality and accessibility of telecommunications
        "Mobile phone subscriptions per 100 inhabitants" // Penetration of mobile phones
    ]
}
