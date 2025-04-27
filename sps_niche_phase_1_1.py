# -*- coding: utf-8 -*-
"""
Created on Tue Apr 22 16:22:00 2025

@author: mdrmi
"""
import random as rnd

def species_niche(sps_list, environmental_niche): 
    '''
    Creates niches of the species in a community. 
    50% of species are generalists (6 resources), 50% specialists (3 resources).
    '''
    niche_sps = {}
    
    generalists = sps_list[:len(sps_list)//2]
    especialists = sps_list[len(sps_list)//2:]
    
    for species in generalists: 
        niche_sps[species] = rnd.sample(environmental_niche, 6)
    for species in especialists: 
        niche_sps[species] = rnd.sample(environmental_niche, 3)
          
    return niche_sps
