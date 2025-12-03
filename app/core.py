import random

def rand100():
    return random.randint(1, 100)

def roll_dice(num_faces, num_dice):
    if num_faces < 1 or num_dice < 1:
        raise ValueError('Number of faces and number of dice must be positive integers.')

    rolls = [random.randint(1, num_faces) for _ in range(num_dice)]
    return {"faces": num_faces, "rolls": rolls}