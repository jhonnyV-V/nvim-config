-- :BlackJackNewGame
-- :BlackJackQuit
-- :BlackJackResetScores
require("blackjack").setup({
  card_style = "large", -- Can be "mini" or "large".
  suit_style = "black", -- Can be "black" or "white".
  keybindings = {
    ["next"] = "j",
    ["finish"] = "k",
    ["quit"] = "q",
  },
})
