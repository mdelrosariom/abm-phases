# -*- coding: utf-8 -*-
"""
Created on Tue Apr 22 15:03:00 2025

@author: mdrmi
"""

import pandas as pd
import numpy as np
import random as rnd

def niche_construction(mainland_island): 
    ''' 
    construct a dataframe with the same dimentions as mainland island and different resources. 
    '''
    
    mainland_resources = list(range(1,30)) #resources present in mainlan
    island_resources = rnd.sample(mainland_island,10) #resources present island. now random number
    environmental_niche = mainland_island.copy() #copy mainland island
    environmental_niche = environmental_niche.replace(0, np.nan) #replace 0 values for NA values (sea)
    
    for i in range(environmental_niche.shape[0]): 
        for j in range(environmental_niche.shape[1]): 
            if environmental_niche.iat[i, j] == 1: #mainland
                environmental_niche.iat[i, j] = rnd.choice(mainland_resources)           
                
            if environmental_niche.iat[i, j] == 2: #island   
                environmental_niche.iat[i, j] = rnd.choice(island_resources)

    return environmental_niche
