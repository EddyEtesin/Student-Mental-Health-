# Student Mental Health Analysis During Online Learning

## Overview
This repository contains a dataset and SQL queries analyzing student mental health during online learning. The analysis explores relationships between academic performance, lifestyle factors (screen time, sleep, physical activity), and mental health indicators (stress levels, anxiety).

## Dataset Description
The dataset `student mental health analysis during online learning` contains the following columns:

- **Demographics**:
  - Age
  - Gender (Male/Female)
  - Education Level (e.g., Class 12, BTech, BA, MA)

- **Lifestyle Factors**:
  - Screen Time (hrs/day)
  - Sleep Duration (hrs)
  - Physical Activity (hrs/week)

- **Mental Health Indicators**:
  - Stress Level (Low/Medium/High)
  - Anxious Before Exams (Yes/No)

- **Academic Performance**:
  - Academic Performance Change (Improved/Same/Declined)

## SQL Queries
The repository includes 22 analytical queries that examine:

1. Basic statistics (average screen time, sleep duration by gender)
2. Correlation analyses (screen time vs. stress, physical activity vs. sleep)
3. Group comparisons (technical vs. arts students, undergrad vs. grad)
4. Stress level analysis
5. Academic performance factors

## How to Use
1. Import the dataset into your MySQL database under schema `dbms2`
2. Run the SQL queries individually to reproduce the analysis
3. Modify queries as needed for your specific database environment

## Key Findings
Some notable insights from the analysis:

- Correlation between higher screen time and higher stress levels
- Differences in sleep patterns between undergraduate and graduate students
- Relationship between physical activity and sleep duration
- Academic performance trends based on lifestyle factors
- Stress level comparisons across different education levels

## Requirements
- MySQL or compatible database system
- Basic SQL knowledge to adapt queries if needed

## File Structure
- `Student Mental Health queried.sql` - Contains all 22 analytical queries
- Dataset should be imported as `dbms2.student mental health analysis during online learning`

Note: The dataset is included in this repository (please ensure it's properly imported before running the queries).
