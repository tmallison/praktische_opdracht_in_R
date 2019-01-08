#--------Template - Onderdeel 2 - Machine Learning - ikml (40 punten) -------------
# Naam student: Thomas Allison
# studienummer: s1095073


# Gekozen dataset https://archive.ics.uci.edu/ml/datasets/Poker+Hand. Beschrijving dataset
# Een pokerhand dataset.
# Inlezen dataset en nul-meeting (10 punten)
# met nul meeting bedoelen we 
# - scatterplots maken. histrogram plots
# - dimensies van je data (aantal rijen, aantal kolommen)
# - numerieke of categorische data
# - missing values? 
# - Bereik van de datapunten?


# 1) S1 ?Suit of card #1?
# Ordinal (1-4) representing {Hearts, Spades, Diamonds, Clubs}
# 
# 2) C1 ?Rank of card #1?
# Numerical (1-13) representing (Ace, 2, 3, ... , Queen, King)
# 
# 3) S2 ?Suit of card #2?
# Ordinal (1-4) representing {Hearts, Spades, Diamonds, Clubs}
# 
# 4) C2 ?Rank of card #2?
# Numerical (1-13) representing (Ace, 2, 3, ... , Queen, King)
# 
# 5) S3 ?Suit of card #3?
# Ordinal (1-4) representing {Hearts, Spades, Diamonds, Clubs}
# 
# 6) C3 ?Rank of card #3?
# Numerical (1-13) representing (Ace, 2, 3, ... , Queen, King)
# 
# 7) S4 ?Suit of card #4?
# Ordinal (1-4) representing {Hearts, Spades, Diamonds, Clubs}
# 
# 8) C4 ?Rank of card #4?
# Numerical (1-13) representing (Ace, 2, 3, ... , Queen, King)
# 
# 9) S5 ?Suit of card #5?
# Ordinal (1-4) representing {Hearts, Spades, Diamonds, Clubs}
# 
# 10) C5 ?Rank of card 5?
#   Numerical (1-13) representing (Ace, 2, 3, ... , Queen, King)
# 
# 11) CLASS ?Poker Hand?
#   Ordinal (0-9)
# 
# 0: Nothing in hand; not a recognized poker hand 
# 1: One pair; one pair of equal ranks within five cards
# 2: Two pairs; two pairs of equal ranks within five cards
# 3: Three of a kind; three equal ranks within five cards
# 4: Straight; five cards, sequentially ranked with no gaps
# 5: Flush; five cards with the same suit
# 6: Full house; pair + different rank three of a kind
# 7: Four of a kind; four equal ranks within five cards
# 8: Straight flush; straight + flush
# 9: Royal flush; {Ace, King, Queen, Jack, Ten} + flush

d = read.table("./data/poker-hand-testing.data.txt", sep = ",", header = FALSE, col.names = c("S1", "C1", "S2", "C2", "S3", "C3", "S4", "C4", "S5", "C5", "CLASS"))
dtrue = read.table("./data/poker-hand-training-true.data.txt", sep = ",", header = FALSE, col.names = c("S1", "C1", "S2", "C2", "S3", "C3", "S4", "C4", "S5", "C5", "CLASS"))


# library(ggplot2)
# ggplot(d, aes(x=CLASS)) + geom_histogram(binwidth=.1)

plot(dtrue,pch="*")

# gekozen classifier of regressie model trainen (10 punten)




# cross validatie of R squared (voor regressie) (10 punten)




# visualisatie en conclusies (10 punten)





