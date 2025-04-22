# -*- coding: utf-8 -*-
"""
Created on Fri Mar 22 15:17:21 2024

@author: mdrmi
"""

def list_of_species(n_species): 
    '''
    Simply creates a list of all species in the island of the way sp1, sp2, sp3... 
    '''
    all_species = []
    for i in range(1,n_species+1): 
        specie = "sp"+str(i) 
        all_species.append(specie)
    return(all_species)
        