from app.core import *

from random import randint

def test_rand100_produces_random_numbers_between_1_and_100():
    trials = [ rand100() for _ in range(1000) ]
    assert max(trials) <= 100, "rand100 produced a number greater than 100"
    assert min(trials) >= 1, "rand100 produced a number less than 1"

def test_rand100_uniform_distribution():
    trials = [ rand100() for _ in range(100000) ]

    average = sum(trials) / len(trials)
    assert abs(average - 50.5) < 1, "Average is not close to expected value of 50.5"

    counts = [0] * 100
    for number in trials:
        counts[number - 1] += 1
    average_count = sum(counts) / len(counts)
    for count in counts:
        assert abs(count - average_count) < average_count * 0.2, "Distribution is not uniform enough"

def test_roll_dice_raises_value_exception_on_out_of_range_inputs():

    try:
        roll_dice(0, 1)
        roll_dice(-1, 1)
        assert False, "roll_dice did not raise ValueError for dice with < 1 face"
    except ValueError:
        pass

    try:
        roll_dice(1, 0)
        roll_dice(1, -1)
        assert False, "roll_dice did not raise ValueError for < 1 die"
    except ValueError:
        pass
    
def test_roll_dice_produces_correct_number_of_rolls_within_range():
    
    for _ in range(1000):

        faces = randint(1,20)
        num_dice = randint(1,10)
        roll = roll_dice(faces, num_dice)

        assert "faces" in roll and isinstance(roll["faces"], int), "roll_dice result missing 'faces' key containing an integer"
        assert "rolls" in roll and isinstance(roll["rolls"], list), "roll_dice result missing 'rolls' key containing a list"

        assert roll["faces"] == faces, f"roll_dice did not return correct number of faces: expected {faces}, got {roll['faces']}"

        rolls = roll["rolls"]
        assert len(rolls) == num_dice, f"roll_dice did not return correct number of rolls: expected {num_dice}, got {len(rolls)}"
        
        for r in rolls:
            assert 1 <= r <= faces, f"roll_dice produced a roll out of range: {roll}"