# -*- coding: utf-8 -*-
"""
Created on Sun Mar 10 11:57:04 2024

@author: mdrmi
"""
import random as rnd

import random as rnd
from collections import defaultdict

def competition(community, plants_to_remove): 
    '''
    For phase 0. At each occupied position, randomly keeps one individual and adds the others
    to the list of plants to remove.
    '''
    #new technique. this creates a directory without specifying keys. (*). the keys
    #will be the positions there
    position_dict = defaultdict(list)

    # Group all individuals by position (*) that is used in combination with this
    for plant in community:
        #we cant add lists to the directory, so we need to transforme it 
        #to a tuple, no problem because tuple is just the key and we dont work with the key
        position_dict[tuple(plant.pos)].append(plant)
    #creates groups of plants based in their position, if they have the same 
    # positon then they are inside the same item

    # For each position with more than one plant, randomly keep one
    for pos, plants in position_dict.items():
        if len(plants) > 1: #if there are more than 1 plant/individual in a position
            rnd.shuffle(plants) #shuffle to avoid bias
            winner = rnd.choice(plants) #chose one to stay
            losers = [p for p in plants if p != winner] #the others go
            plants_to_remove.extend(losers) #adds the plants that will be eliminated to the list

    return plants_to_remove
