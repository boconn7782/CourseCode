# ============================================================
# TODO 1: Fill in your title block.
# ============================================================
# Programming #<Unit #> <Pre-class Lesson or Homework> Part <Part # of the Lab>
# <First Initial>.<Last Name>
# <Name of Script>
# <Appropriate credit where credit is due, as applicable>
# <Description of what the program will do.> 



# ============================================================
# PROVIDED CODE - BLACK BOX
# ------------------------------------------------------------
# The function below uses a tool we have not covered yet. You do
# not need to understand how it works internally.
#
# You will get code like this from me whenever it makes an
# activity better than it could be with only what we have covered
# so far. Don't spend effort decoding it. Do notice it working -
# seeing something in action before you learn it often makes it
# click faster when you get there.
#
# But "you don't need to understand how it works" is not the same
# as "you don't need to know what it does." Those are two
# different things, and the difference is the comment inside the
# function.
#
# That comment is the only documentation you get. It is written to
# tell you everything you need in order to USE this function
# correctly, without telling you anything about how it is built.
# Read it the way you would read instructions for a tool you just
# bought; you don't need to know how the factory made it, but you
# do need to know what it does and what its limits are.
#
# This is what good comments are for. Keep that in mind when you
# write your own functions and scripts.
# ============================================================

import random


def random_number(low, high):
    # Returns a randomly chosen whole number.
    #
    #   low    the smallest value this can return
    #   high   the largest value this can return
    #
    # Both ends are included. So random_number(1, 6) behaves like
    # rolling a six-sided die: it can return 1, it can return 6,
    # and anything in between.
    #
    # Limits worth knowing:
    #   - It only ever returns whole numbers. You cannot ask it
    #     for a decimal.
    #   - It cannot be told to return only certain values, such as
    #     even numbers or multiples of 5. Every whole number in the
    #     range is equally possible.
    #

    return random.randint(low, high)


# ============================================================
# PROVIDED CODE - WORKED EXAMPLE
# ------------------------------------------------------------
# You DO want to read this one. The two functions you are about
# to write follow the same shape: check a condition, return a
# value, and let the next check handle everything else.
# ============================================================


def type_name(type_number):
    # Returns the type based on predetermined numerical inputs.
    #
    # Limits worth knowing:
    #   - Only values 1 and 2 are predetermined,
    #     all other inputs use the default
    #
    if type_number == 1:
        return "Fire"
    elif type_number == 2:
        return "Water"
    else:
        return "Grass"


# ============================================================
# YOUR FUNCTIONS
# ============================================================


def effectiveness(attacker_type, defender_type):
    # ---- TODO 2 ----
    #
    # Return one of three strings: "weakness", "resistance", or
    # "neutral".
    #
    # The algorithm:
    #   1. If both types are the same, it is neutral.
    #   2. Otherwise, check whether the attacker's type beats the
    #      defender's type:
    #           Fire (1)  beats Grass (3)
    #           Grass (3) beats Water (2)
    #           Water (2) beats Fire (1)
    #      If it does, this is a weakness hit.
    #   3. Anything left over is a resistance hit.
    #
    # Step 2 needs you to check three separate pairs. You can do that
    # with one condition using "and" and "or" together, or with three
    # separate elif branches. Both are correct.


    pass  # delete this line and write your code


def apply_effect(attack, effect):
    # ---- TODO 3 ----
    #
    # Return the final damage number.
    #
    #   weakness   -> double the attack
    #   resistance -> subtract 10 from the attack
    #   neutral    -> the attack, unchanged
    #
    # One catch: damage should never be negative. If your math
    # produces a number below zero, make it zero before returning it.

    pass  # delete this line and write your code


# ============================================================
# MAIN LOGIC
# ============================================================

print("Pick your card's type:")
print("  1 - Fire    (Charmander, Fire Fang, 20 damage, 70 HP)")
print("  2 - Water   (Squirtle, Skull Bash, 20 damage, 50 HP)")
print("  3 - Grass   (Bulbasaur, Vine Whip, 10 damage, 70 HP)")

# ---- TODO 4 ----
# Input your card information
#

player_type = input("Type number: ")
player_hp = input("Your card's HP: ")
player_attack = input("Your attack damage: ")


# Generate the opponent's card.
computer_type = random_number(1, 3)
computer_hp = random_number(4, 8) * 10
computer_attack = random_number(1, 3) * 10

# ---- TODO 5 ----
# Work out how effective each attack is.
#
# Call effectiveness() twice - once for your attack against theirs,
# once for theirs against yours. The order of the arguments matters.
#


# ---- TODO 6 ----
# Turn those effects into damage numbers.
#
# Call apply_effect() twice.
#


# ---- TODO 7 ----
# Subtract the damage from each side's HP.
#


# ---- TODO 8 ----
# Output the results of the initial assessments of effect and damage
# 

print()
print(f"You sent out a {type_name(player_type)} card: {player_hp} HP, {player_attack} damage.")
print(f"The opponent sent out a {type_name(computer_type)} card: {computer_hp} HP, {computer_attack} damage.")
# print()
# print(f"Your attack is { < player effect > }: { < damage to computer > } damage dealt.")
# print(f"Their attack is { < computer effect > }: { < damage to player > } damage dealt.")
# print()
# print(f"Your HP: { < Remaining player HP > }")
# print(f"Their HP: { < Remaining computer HP > }")
# print()


# ---- TODO 8 ----
# Decide the result.
#
# Whoever has MORE HP remaining wins the exchange. Print one of
# three messages - you win, you lose, or it's a tie.
#
# A tie is genuinely possible here, so do not skip that case.


# ============================================================
# TODO 9: Paste the output from TWO runs below, as comments.
#         The two runs must show DIFFERENT opponent types.
#         If you get the same type twice, run it again.
# ============================================================

# RUN 1:


# RUN 2:
