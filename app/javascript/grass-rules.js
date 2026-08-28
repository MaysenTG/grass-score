// Grass rules used for client-side Fuse.js searching.
// This file mirrors app/data/rules.json for frontend usage.

export const grassRules = [

  // ============================================================
  // GAME
  // ============================================================

  {
    id: "game-overview",
    category: "game",
    title: "Grass overview",
    text: `
      Grass is a strategy card game for 2 to 6 players. The objective is
      to build profit by opening a Marketplace, playing Peddle cards,
      protecting exposed Peddles, and interfering with competitors.

      Players compete over multiple rounds. At the end of each round,
      profits are calculated and added to the player's cumulative score.
      The normal winning threshold is $250,000.

      The game was invented by Jeff London and was originally published
      in 1979. The current rules describe a 104-card deck plus four
      replacement cards.
    `,
    keywords: [
      "Grass",
      "card game",
      "strategy",
      "2 players",
      "3 players",
      "4 players",
      "5 players",
      "6 players",
      "250000",
      "Baron",
      "Baroness",
      "104 cards",
      "Jeff London"
    ]
  },

  {
    id: "goal",
    category: "game",
    title: "Goal and winning condition",
    text: `
      The goal is to accumulate at least $250,000 in profit.

      At the end of each round, all players calculate their net profit
      for that round. The round profits are added to their cumulative
      scores.

      Once a player's end-of-round total reaches or exceeds $250,000,
      the game ends. That player wins and is crowned Baron or Baroness
      of the Deal.

      If multiple players reach $250,000 or more during the same round,
      the player with the highest total wins.

      The players may agree to use a different winning amount.
    `,
    keywords: [
      "goal",
      "objective",
      "win",
      "winner",
      "winning",
      "250000",
      "$250,000",
      "Baron",
      "Baroness",
      "highest total",
      "agreed amount"
    ]
  },

  // ============================================================
  // SETUP
  // ============================================================

  {
    id: "setup",
    category: "setup",
    title: "Game setup",
    text: `
      The dealer gives six cards to every player.

      The remaining cards are placed face down in the center of the table.
      This pile is called the GRASS STACK.

      Discarded cards are placed face up beside the Grass Stack in the
      WASTED PILE.

      Each player needs two areas in front of them:
      a HASSLE PILE and a MARKETPLACE.

      The player to the dealer's left starts the first round.
      Play proceeds clockwise.

      In subsequent rounds the direction alternates. The winner of the
      previous round becomes the dealer, and play proceeds in the
      opposite direction from the previous round.
    `,
    keywords: [
      "setup",
      "start",
      "starting hand",
      "six cards",
      "6 cards",
      "dealer",
      "Grass Stack",
      "Wasted Pile",
      "Hassle Pile",
      "Marketplace",
      "clockwise",
      "counter-clockwise",
      "left of dealer"
    ]
  },

  {
    id: "turn-order",
    category: "turn",
    title: "Normal turn sequence",
    text: `
      On a normal turn the player must:

      1. Take one card from the top of the GRASS STACK.
      2. Play one card.
      3. Optionally make one Deal.

      After taking a card, the player temporarily has seven cards.
      Playing a card normally reduces the hand back to six.

      A Deal is optional and can occur before or after playing the card.

      A player whose turn is skipped cannot Take, Play, or Deal.
    `,
    keywords: [
      "turn",
      "turn order",
      "take a card",
      "play a card",
      "deal",
      "trade",
      "switch",
      "seven cards",
      "7 cards",
      "six cards",
      "6 cards",
      "skip turn"
    ]
  },

  // ============================================================
  // PLAY LOCATIONS
  // ============================================================

  {
    id: "play-locations",
    category: "rules",
    title: "Where cards can be played",
    text: `
      A card can generally be played in one of four places:

      1. Your HASSLE PILE.
         Market Open starts your Marketplace here. Heat Off cards can
         resolve Heat On cards here. Market Close can end the round here.

      2. Your MARKETPLACE.
         Peddle cards and Protected cards are played here.

      3. An opponent's HASSLE PILE.
         Heat On cards are played here to interfere with that opponent.

      4. The WASTED PILE.
         Cards that are discarded or cards such as Nirvana and Paranoia
         that specifically operate from the Wasted Pile are played here.
    `,
    keywords: [
      "where play card",
      "play location",
      "Hassle Pile",
      "Marketplace",
      "Wasted Pile",
      "opponent",
      "Heat On",
      "Heat Off",
      "Market Open",
      "Market Close"
    ]
  },

  // ============================================================
  // DEALS
  // ============================================================

  {
    id: "deals",
    category: "deal",
    title: "Deals, Trades and Switches",
    text: `
      After taking a card and either before or after playing a card,
      a player may make one Deal.

      A Deal can be a TRADE or a SWITCH.

      TRADE:
      The active player negotiates with another player to exchange a card
      from their hand for a card in that other player's hand.

      Other players may trade with the active player, but they may not
      trade with one another outside the active player's Deal.

      SWITCH:
      The active player may exchange a visible, unprotected Peddle on
      their Marketplace for a visible, unprotected Peddle on another
      player's Marketplace.

      A Switch is not available against a Peddle that is protected.
      A player under Heat cannot Switch their Marketplace.

      Only one Deal is permitted per normal turn.
    `,
    keywords: [
      "deal",
      "trade",
      "switch",
      "exchange",
      "negotiate",
      "hand",
      "visible",
      "unprotected",
      "Peddle",
      "Marketplace",
      "swap"
    ]
  },

  // ============================================================
  // ROUNDS
  // ============================================================

  {
    id: "rounds",
    category: "round",
    title: "How rounds end",
    text: `
      A round ends in either of two ways:

      1. A player plays Market Close.
      2. The GRASS STACK is exhausted.

      When the last Grass Stack card is taken, that player completes
      their turn normally and then the round ends.

      After the round ends, players score their profits.
    `,
    keywords: [
      "round",
      "round ends",
      "end round",
      "Grass Stack empty",
      "Grass Stack exhausted",
      "last card",
      "Market Close"
    ]
  },

  // ============================================================
  // MARKET CARDS
  // ============================================================

  {
    id: "market-open",
    category: "market",
    title: "Market Open",
    cardName: "Market Open",
    quantity: 10,
    text: `
      Market Open is the card required to start peddling.

      It is played face up as the first card on the player's HASSLE PILE.
      Once Market Open is visible and there is no Heat On card covering it,
      the player may play Peddle cards onto their Marketplace.

      Until Market Open has been played, the player cannot put Peddle cards
      onto their Marketplace.

      A player without an open Marketplace cannot discard Sold Out,
      Doublecrossed, or Utterly Wiped Out onto the Wasted Pile.

      A player may attempt to obtain Market Open through a Trade.
    `,
    keywords: [
      "Market Open",
      "open market",
      "open Marketplace",
      "start peddling",
      "start selling",
      "Hassle Pile",
      "Peddle prerequisite",
      "first card",
      "trade Market Open"
    ]
  },

  {
    id: "market-close",
    category: "market",
    title: "Market Close",
    cardName: "Market Close",
    quantity: 5,
    text: `
      Market Close immediately ends the current round.

      It may only be played when the player's Marketplace is open and
      their HASSLE PILE is not showing a Heat On card.

      Market Close is useful when the player believes they have the
      highest profit in the round and wants to collect the $25,000
      round-winning bonus.
    `,
    keywords: [
      "Market Close",
      "close market",
      "end round",
      "finish round",
      "end hand",
      "25000 bonus",
      "$25,000 bonus",
      "highest profit"
    ]
  },

  // ============================================================
  // PEDDLE
  // ============================================================

  {
    id: "peddle-overview",
    category: "peddle",
    title: "Peddle cards",
    cardName: "Peddle",
    quantity: 28,
    text: `
      Peddle cards represent money earned from selling cannabis.

      There are six named varieties:
      Home Grown, Mexico, Colombia, Jamaica, Panama, and Dr. Feelgood.

      Peddle values range from $5,000 to $100,000.

      A Peddle can only be played onto the player's Marketplace after
      Market Open has been played and remains visible without Heat On
      covering it.

      There is no stated limit to the number of Peddle cards that can be
      displayed on a Marketplace.

      Peddles in the Marketplace can be either protected or unprotected.
      Unprotected Peddles are at risk of being stolen, switched, or lost
      through certain effects.

      Peddles remaining in a player's hand at scoring are relevant to
      the round calculation: the value of the highest Peddle remaining
      in the player's hand is subtracted.
    `,
    keywords: [
      "Peddle",
      "Peddle card",
      "weed",
      "money",
      "profit",
      "Home Grown",
      "Mexico",
      "Colombia",
      "Jamaica",
      "Panama",
      "Dr Feelgood",
      "Dr. Feelgood",
      "5000",
      "100000",
      "hand penalty",
      "highest Peddle"
    ]
  },

  // Preserve the known named-value information without inventing
  // values not explicitly established by the official rules.
  {
    id: "peddle-panama",
    category: "peddle",
    title: "Panama Peddle",
    cardName: "Panama",
    text: `
      Panama is one of the six named Peddle varieties.
      The official rules' example identifies a Panama Peddle as worth
      $50,000.
    `,
    value: 50000,
    keywords: [
      "Panama",
      "Panama Peddle",
      "50000",
      "$50,000"
    ]
  },

  {
    id: "peddle-jamaica",
    category: "peddle",
    title: "Jamaica Peddle",
    cardName: "Jamaica",
    text: `
      Jamaica is one of the six named Peddle varieties.
      The official rules' example identifies a Jamaican Peddle as worth
      $25,000.
    `,
    value: 25000,
    keywords: [
      "Jamaica",
      "Jamaican",
      "Jamaica Peddle",
      "25000",
      "$25,000"
    ]
  },

  {
    id: "peddle-dr-feelgood",
    category: "peddle",
    title: "Dr. Feelgood Peddle",
    cardName: "Dr. Feelgood",
    text: `
      Dr. Feelgood is a Peddle card and is described as the highest-valued
      Peddle in the game.

      Dr. Feelgood can never be protected by a Protected card.

      Because it is the highest-valued Peddle, it is especially valuable
      but remains exposed to effects that target unprotected Peddles.
    `,
    keywords: [
      "Dr Feelgood",
      "Dr. Feelgood",
      "highest value",
      "highest Peddle",
      "cannot protect",
      "unprotected"
    ]
  },

  // ============================================================
  // PROTECTION
  // ============================================================

  {
    id: "protected-overview",
    category: "protection",
    title: "Protected cards",
    cardName: "Protected",
    quantity: 6,
    text: `
      Protected cards are placed over Peddle cards on the Marketplace
      to protect the Peddles from effects that target unprotected Peddles.

      The deck contains six Protected cards:
      two Grab a Snack cards worth $25,000 coverage,
      two Catch a Buzz cards worth $25,000 coverage,
      and two Lust Conquers All cards worth $50,000 coverage.

      A Protected card may protect more than one Peddle card.

      The total protection coverage must be equal to or greater than
      the value of the Peddle card or cards being protected.

      Additional Peddles cannot later be slid underneath an existing
      Protected card.

      Dr. Feelgood can never be protected.

      Peddles must be played before Protected cards, meaning there is
      always a period in which newly played Peddle money is exposed.
    `,
    keywords: [
      "Protected",
      "protection",
      "protect",
      "protect Peddle",
      "Grab a Snack",
      "Catch a Buzz",
      "Lust Conquers All",
      "25000",
      "50000",
      "coverage",
      "unprotected",
      "Dr Feelgood"
    ]
  },

  {
    id: "grab-a-snack",
    category: "protection",
    title: "Grab a Snack",
    cardName: "Grab a Snack",
    quantity: 2,
    value: 25000,
    text: `
      Grab a Snack is a $25,000 Protected card.

      It is used on the Marketplace to protect Peddle cards up to its
      available $25,000 protection value.
    `,
    keywords: [
      "Grab a Snack",
      "Protected",
      "25000",
      "$25,000",
      "protect"
    ]
  },

  {
    id: "catch-a-buzz",
    category: "protection",
    title: "Catch a Buzz",
    cardName: "Catch a Buzz",
    quantity: 2,
    value: 25000,
    text: `
      Catch a Buzz is a $25,000 Protected card.

      It is used on the Marketplace to protect Peddle cards up to its
      available $25,000 protection value.
    `,
    keywords: [
      "Catch a Buzz",
      "Protected",
      "25000",
      "$25,000",
      "protect"
    ]
  },

  {
    id: "lust-conquers-all",
    category: "protection",
    title: "Lust Conquers All",
    cardName: "Lust Conquers All",
    quantity: 2,
    value: 50000,
    text: `
      Lust Conquers All is a $50,000 Protected card.

      It can protect Peddle value up to $50,000, subject to the rule that
      protection coverage must be equal to or greater than the Peddle
      value being protected.

      Dr. Feelgood can never be protected.
    `,
    keywords: [
      "Lust Conquers All",
      "Protected",
      "50000",
      "$50,000",
      "protect",
      "Dr Feelgood"
    ]
  },

  // ============================================================
  // HEAT ON
  // ============================================================

  {
    id: "heat-on-overview",
    category: "heat",
    title: "Heat On",
    text: `
      Heat On cards temporarily freeze an opponent's Marketplace.

      There are four Heat On varieties:
      Search & Seizure,
      Detained,
      Bust,
      Felony.

      Each Heat On type has three cards in the 104-card deck.

      A Heat On card is played on an opponent's HASSLE PILE, on top
      of their visible Market Open.

      While Heat On is active, the affected player cannot Switch,
      play Peddle cards, or play Protected cards.

      A Heat On card cannot be played on top of another Heat On card.
      Only one hassle can be active at a time.

      Heat must be removed before the Marketplace can resume normal
      Peddling and protection.
    `,
    keywords: [
      "Heat On",
      "heat",
      "police",
      "freeze",
      "block",
      "Marketplace",
      "Hassle Pile",
      "Peddle",
      "Protected",
      "Switch",
      "Search and Seizure",
      "Detained",
      "Bust",
      "Felony"
    ]
  },

  {
    id: "heat-on-bust",
    category: "heat",
    title: "Heat On: Bust",
    cardName: "Heat On: Bust",
    quantity: 3,
    text: `
      Heat On: Bust is played on an opponent's HASSLE PILE over their
      visible Market Open.

      It prevents that player from Switching, playing Peddles, or playing
      Protected cards until the Heat is removed.

      The corresponding Heat Off card is Immunity.
    `,
    keywords: [
      "Bust",
      "Heat On Bust",
      "Immunity",
      "Heat Off",
      "police",
      "blocked"
    ]
  },

  {
    id: "heat-on-detained",
    category: "heat",
    title: "Heat On: Detained",
    cardName: "Heat On: Detained",
    quantity: 3,
    text: `
      Heat On: Detained blocks an opponent's Marketplace.

      It prevents Switching, playing Peddles, and playing Protected cards
      until the corresponding Heat Off card, A Breeze To Fly, is played.
    `,
    keywords: [
      "Detained",
      "Heat On Detained",
      "A Breeze To Fly",
      "Heat Off",
      "blocked"
    ]
  },

  {
    id: "heat-on-felony",
    category: "heat",
    title: "Heat On: Felony",
    cardName: "Heat On: Felony",
    quantity: 3,
    text: `
      Heat On: Felony freezes an opponent's Marketplace.

      It prevents Switching, playing Peddles, and playing Protected cards
      until the corresponding Heat Off: Hearsay Evidence card removes it.
    `,
    keywords: [
      "Felony",
      "Heat On Felony",
      "Hearsay Evidence",
      "Heat Off",
      "blocked"
    ]
  },

  {
    id: "heat-on-search",
    category: "heat",
    title: "Heat On: Search & Seizure",
    cardName: "Heat On: Search & Seizure",
    quantity: 3,
    text: `
      Heat On: Search & Seizure blocks an opponent's Marketplace.

      It prevents Switching, playing Peddles, and playing Protected cards
      until the corresponding Heat Off: Charges Dropped card removes it.
    `,
    keywords: [
      "Search and Seizure",
      "Search & Seizure",
      "Heat On",
      "Charges Dropped",
      "Heat Off",
      "blocked"
    ]
  },

  // ============================================================
  // HEAT OFF
  // ============================================================

  {
    id: "heat-off-overview",
    category: "heat",
    title: "Heat Off",
    text: `
      Heat Off cards remove Heat On cards from a player's HASSLE PILE.

      There are four matching Heat Off varieties, with five copies
      of each:

      Bust -> Immunity
      Detained -> A Breeze To Fly
      Felony -> Hearsay Evidence
      Search & Seizure -> Charges Dropped

      The Heat Off card must correspond to the Heat On card being removed.

      After Heat is removed, the player can reveal their Market Open
      and resume normal Marketplace activity.

      If a player does not have the appropriate Heat Off card, they can
      attempt to obtain one through a Trade.
    `,
    keywords: [
      "Heat Off",
      "remove Heat",
      "remove heat",
      "Immunity",
      "A Breeze To Fly",
      "Hearsay Evidence",
      "Charges Dropped",
      "match",
      "corresponding",
      "Trade"
    ]
  },

  {
    id: "immunity",
    category: "heat",
    title: "Immunity",
    cardName: "Immunity",
    quantity: 5,
    counters: "Bust",
    text: `
      Immunity is the Heat Off card corresponding to Heat On: Bust.

      Playing Immunity removes Bust and allows the player to resume
      normal Marketplace activity.
    `,
    keywords: [
      "Immunity",
      "Bust",
      "Heat Off",
      "counter Bust",
      "remove Bust"
    ]
  },

  {
    id: "a-breeze-to-fly",
    category: "heat",
    title: "A Breeze To Fly",
    cardName: "A Breeze To Fly",
    quantity: 5,
    counters: "Detained",
    text: `
      A Breeze To Fly is the Heat Off card corresponding to
      Heat On: Detained.
    `,
    keywords: [
      "A Breeze To Fly",
      "Detained",
      "Heat Off",
      "counter Detained"
    ]
  },

  {
    id: "hearsay-evidence",
    category: "heat",
    title: "Hearsay Evidence",
    cardName: "Hearsay Evidence",
    quantity: 5,
    counters: "Felony",
    text: `
      Hearsay Evidence is the Heat Off card corresponding to
      Heat On: Felony.
    `,
    keywords: [
      "Hearsay Evidence",
      "Felony",
      "Heat Off",
      "counter Felony"
    ]
  },

  {
    id: "charges-dropped",
    category: "heat",
    title: "Charges Dropped",
    cardName: "Charges Dropped",
    quantity: 5,
    counters: "Search & Seizure",
    text: `
      Charges Dropped is the Heat Off card corresponding to
      Heat On: Search & Seizure.
    `,
    keywords: [
      "Charges Dropped",
      "Search and Seizure",
      "Search & Seizure",
      "Heat Off",
      "counter Search"
    ]
  },

  // ============================================================
  // PAY FINE
  // ============================================================

  {
    id: "pay-fine",
    category: "heat",
    title: "Pay Fine / Heat Off",
    cardName: "Pay Fine/Heat Off",
    quantity: 4,
    text: `
      Pay Fine/Heat Off removes any of the four types of Heat On.

      Unlike a normal Heat Off card, it does not need to match the
      specific Heat On type.

      To use it, the player must discard a Peddle from their Marketplace
      as the fine.

      If the Peddle being discarded is Protected, its Protected cover
      is also discarded.

      The discarded cards go to the WASTED PILE.

      Therefore Pay Fine can remove any Heat On, but costs the player
      one Marketplace Peddle.
    `,
    keywords: [
      "Pay Fine",
      "Pay Fine Heat Off",
      "any Heat",
      "remove any Heat",
      "fine",
      "penalty",
      "discard Peddle",
      "protected Peddle",
      "Wasted Pile"
    ]
  },

  // ============================================================
  // NIRVANA
  // ============================================================

  {
    id: "nirvana-overview",
    category: "nirvana",
    title: "Nirvana cards",
    text: `
      Nirvana cards provide a bonus and also remove active Heat.

      There are two Nirvana cards:
      Stonehigh and Euphoria.

      Both are played on the Wasted Pile.

      A Nirvana card removes Heat On from the player's HASSLE PILE,
      gives the player an extra turn, and causes every other player
      to give the Nirvana player an unprotected Peddle.

      Stonehigh takes the lowest unprotected Peddle from each other player.

      Euphoria takes the highest unprotected Peddle from each other player.

      If another player has no unprotected Peddle, that player gives
      nothing, but the Nirvana player still receives the extra turn.
    `,
    keywords: [
      "Nirvana",
      "Stonehigh",
      "Euphoria",
      "extra turn",
      "remove Heat",
      "cancel Heat",
      "lowest",
      "highest",
      "unprotected",
      "Peddle",
      "Wasted Pile"
    ]
  },

  {
    id: "stonehigh",
    category: "nirvana",
    title: "Stonehigh",
    cardName: "Stonehigh",
    quantity: 5,
    text: `
      Stonehigh is a Nirvana card and also removes Heat.

      Play Stonehigh on the Wasted Pile.

      It removes any Heat On from the player's HASSLE PILE.

      Every other player must give the Stonehigh player their lowest
      unprotected Peddle, placing that Peddle on the Stonehigh player's
      Marketplace.

      If a player has no unprotected Peddle, they give nothing.

      The Stonehigh player still receives an extra turn.
    `,
    keywords: [
      "Stonehigh",
      "Nirvana",
      "Heat Off",
      "extra turn",
      "lowest Peddle",
      "lowest unprotected Peddle",
      "every player",
      "Wasted Pile"
    ]
  },

  {
    id: "euphoria",
    category: "nirvana",
    title: "Euphoria",
    cardName: "Euphoria",
    quantity: 1,
    text: `
      Euphoria is a Nirvana card.

      It is played like Stonehigh on the Wasted Pile.

      It removes Heat On from the player's HASSLE PILE and gives the
      player an extra turn.

      Every other player must give the Euphoria player their highest
      unprotected Peddle.

      If a player has no unprotected Peddle, they give nothing.
    `,
    keywords: [
      "Euphoria",
      "Nirvana",
      "extra turn",
      "highest Peddle",
      "highest unprotected Peddle",
      "remove Heat",
      "Heat Off"
    ]
  },

  // ============================================================
  // PARANOIA
  // ============================================================

  {
    id: "paranoia-overview",
    category: "paranoia",
    title: "Paranoia cards",
    text: `
      There are three Paranoia cards:
      Sold Out,
      Doublecrossed,
      Utterly Wiped Out.

      These cards have negative consequences when played, but keeping
      one in hand until the end of a round also creates a scoring penalty.

      If a Paranoia card is played on the Wasted Pile, its special penalty
      still occurs and every player passes an undisclosed card from their
      hand to the player ahead of them in the rotation.

      If a Paranoia card remains in a player's hand at scoring, the player
      is penalized:

      Sold Out: $25,000
      Doublecrossed: $50,000
      Utterly Wiped Out: $100,000

      A player therefore has to decide whether playing the Paranoia card
      is preferable to keeping it and taking its end-of-round penalty.

      A player without an open Marketplace cannot discard Paranoia cards
      onto the Wasted Pile.
    `,
    keywords: [
      "Paranoia",
      "Sold Out",
      "Doublecrossed",
      "Double Crossed",
      "Utterly Wiped Out",
      "penalty",
      "25,000",
      "50,000",
      "100,000",
      "pass card",
      "hand",
      "Wasted Pile"
    ]
  },

  {
    id: "sold-out",
    category: "paranoia",
    title: "Sold Out",
    cardName: "Sold Out",
    quantity: 4,
    text: `
      Sold Out is a Paranoia card.

      When played on the Wasted Pile, the player must discard their
      lowest unprotected Peddle from their Marketplace.

      The player then misses their next turn.

      Each player, including the player who played Sold Out, gives one
      undisclosed card from their hand to the player ahead of them in
      the rotation.

      If the player has no unprotected Peddle to discard, the discard
      requirement cannot remove a protected Peddle.

      If Sold Out remains in a player's hand at the end of the round,
      the player loses $25,000 in scoring.

      A player without an open Marketplace cannot discard Sold Out.
    `,
    keywords: [
      "Sold Out",
      "Soldout",
      "Paranoia",
      "lowest Peddle",
      "lowest unprotected",
      "skip turn",
      "miss next turn",
      "pass card",
      "undisclosed card",
      "25000",
      "$25,000"
    ]
  },

  {
    id: "doublecrossed",
    category: "paranoia",
    title: "Doublecrossed",
    cardName: "Doublecrossed",
    quantity: 3,
    text: `
      Doublecrossed is a Paranoia card.

      When played on the Wasted Pile, the player discards their highest
      unprotected Peddle from their Marketplace.

      The player then skips two turns.

      Every player, including the player who played Doublecrossed,
      passes one undisclosed card from their hand to the player ahead
      of them in the rotation.

      If Doublecrossed remains in a player's hand at the end of the round,
      the player receives a $50,000 scoring penalty.

      The card may also be spelled or referred to as "Double Crossed".
    `,
    keywords: [
      "Doublecrossed",
      "Double Crossed",
      "Double-crossed",
      "Paranoia",
      "highest Peddle",
      "highest unprotected",
      "skip two turns",
      "two turns",
      "pass card",
      "50000",
      "$50,000"
    ]
  },

  {
    id: "utterly-wiped-out",
    category: "paranoia",
    title: "Utterly Wiped Out",
    cardName: "Utterly Wiped Out",
    quantity: 1,
    text: `
      Utterly Wiped Out is the most severe Paranoia card.

      When played on the Wasted Pile, the player's entire HASSLE PILE
      and MARKETPLACE are discarded to the Wasted Pile.

      This includes the Market Open card, all Peddles, and all Protected
      cards.

      The player skips their next two turns.

      After the two skipped turns, the player must start over with a
      new Market Open card.

      The card may be passed to another player by the Paranoia card
      passing mechanism.

      If Utterly Wiped Out remains in a player's hand at the end of a
      round, it causes a $100,000 scoring penalty.

      A player without an open Marketplace cannot discard it.
    `,
    keywords: [
      "Utterly Wiped Out",
      "Wiped Out",
      "Paranoia",
      "destroy Marketplace",
      "destroy Hassle Pile",
      "discard everything",
      "Market Open",
      "Peddles",
      "Protected",
      "skip two turns",
      "reopen",
      "100000",
      "$100,000"
    ]
  },

  // ============================================================
  // SKIM
  // ============================================================

  {
    id: "skim-overview",
    category: "skim",
    title: "Skim cards",
    text: `
      Skim cards allow players to take money from other players.

      There are two Skim cards:
      Steal Your Neighbor's Pot and The Banker.

      Steal Your Neighbor's Pot steals an unprotected Peddle directly
      from another player's Marketplace.

      The Banker is held in the player's hand until the end of the round
      and affects scoring.
    `,
    keywords: [
      "Skim",
      "steal",
      "take",
      "Peddle",
      "money",
      "Steal Your Neighbor's Pot",
      "Banker"
    ]
  },

  {
    id: "steal-your-neighbors-pot",
    category: "skim",
    title: "Steal Your Neighbor's Pot",
    cardName: "Steal Your Neighbor's Pot",
    quantity: 4,
    text: `
      Steal Your Neighbor's Pot is a Skim card.

      The player can play it on the Wasted Pile if their own Marketplace
      is open and free of Heat.

      The player then takes one unprotected Peddle from another player
      whose Marketplace is also open and free of Heat.

      The stolen Peddle moves directly from the victim's Marketplace
      to the thief's Marketplace.

      You cannot steal from a player whose Marketplace has an existing
      Heat/hassle.

      Protected Peddles cannot be stolen by this card.
    `,
    keywords: [
      "Steal Your Neighbor's Pot",
      "Steal Your Neighbour's Pot",
      "steal",
      "Skim",
      "unprotected",
      "Peddle",
      "Marketplace",
      "open",
      "Heat",
      "hassle"
    ]
  },

  {
    id: "banker",
    category: "skim",
    title: "The Banker",
    cardName: "The Banker",
    quantity: 1,
    text: `
      The Banker is a special Skim card that should be kept in the
      player's hand.

      It is only valid when the player still has it in their hand at
      the end of the round during scoring.

      The Banker holder skims $5,000 from every other player who has
      unprotected Peddles.

      Players with no unprotected Peddles are not charged.

      The Banker holder also receives a $5,000 bonus.

      The money is deducted from the other players' at-risk/unprotected
      profit during scoring.

      Because The Banker must be held until the end of the round,
      playing or discarding it prevents the scoring bonus.
    `,
    keywords: [
      "The Banker",
      "Banker",
      "skim",
      "5000",
      "$5,000",
      "bonus",
      "unprotected Peddles",
      "at-risk profit",
      "end of round",
      "scoring"
    ]
  },

  // ============================================================
  // SCORING
  // ============================================================

  {
    id: "scoring",
    category: "scoring",
    title: "End-of-round scoring",
    text: `
      At the end of every round, each player's Marketplace Peddles are
      counted.

      Protected Peddles contribute protected profit.

      Unprotected Peddles contribute at-risk profit.

      If a player holds The Banker, they skim $5,000 from each other
      player with unprotected Peddles, excluding players with none,
      and receive an additional $5,000 Banker bonus.

      The player then reveals their remaining hand.

      The following are subtracted from the player's round result:

      - $25,000 for a Sold Out card left in hand.
      - $50,000 for a Doublecrossed card left in hand.
      - $100,000 for an Utterly Wiped Out card left in hand.
      - The value of the highest Peddle card left in the player's hand.

      The resulting amount is the player's net profit for the round.

      The player with the largest net profit in the round receives an
      additional $25,000 bonus.

      Round scores are then added to the player's cumulative score.
    `,
    keywords: [
      "score",
      "scoring",
      "end of round",
      "protected profit",
      "at-risk profit",
      "unprotected profit",
      "Banker",
      "25000",
      "50000",
      "100000",
      "highest Peddle",
      "hand",
      "bonus",
      "net profit"
    ]
  },

  {
    id: "highest-peddle-hand-penalty",
    category: "scoring",
    title: "Highest Peddle left in hand",
    text: `
      At the end of a round, after the Marketplace is scored, the player
      reveals their remaining hand.

      The value of the highest Peddle card still in the hand is subtracted
      from the player's net round profit.

      This makes it costly to hold valuable Peddle cards in the hand
      instead of getting them onto the Marketplace.
    `,
    keywords: [
      "highest Peddle",
      "Peddle in hand",
      "hand penalty",
      "scoring",
      "subtract",
      "deduct",
      "end round"
    ]
  },

  {
    id: "round-winner-bonus",
    category: "scoring",
    title: "Round winner bonus",
    text: `
      After calculating each player's net profit for the round, the player
      with the largest net profit receives a $25,000 bonus.

      This bonus is awarded even if the player does not yet have enough
      cumulative profit to win the entire game.
    `,
    keywords: [
      "round winner",
      "winner bonus",
      "25000",
      "$25,000",
      "bonus",
      "largest net profit"
    ]
  },

  {
    id: "broke-score",
    category: "scoring",
    title: "Negative scores and going broke",
    text: `
      If a player's end-of-round total is less than zero, it may be rounded
      up to zero.

      If a player has accumulated a positive score in an earlier round
      and then has a negative result in a later round, the cumulative
      total decreases accordingly.

      At the beginning of a new round, accounts that are already at zero
      remain at zero rather than carrying a negative balance.
    `,
    keywords: [
      "broke",
      "negative",
      "zero",
      "score below zero",
      "round down",
      "round up",
      "cumulative score"
    ]
  },

  {
    id: "new-round",
    category: "round",
    title: "Starting another round",
    text: `
      If nobody has reached the winning amount, collect all cards,
      including cards that were on players' Marketplaces and Hassle Piles.

      Shuffle all cards and deal six cards to each player again.

      Scores carry over from the previous rounds.

      The winner of the previous round becomes the dealer and the
      direction of play alternates.
    `,
    keywords: [
      "new round",
      "next round",
      "shuffle",
      "redeal",
      "six cards",
      "6 cards",
      "carry over score",
      "dealer",
      "alternate direction"
    ]
  },

  // ============================================================
  // CARD COUNTS / DECK COMPOSITION
  // ============================================================

  {
    id: "deck-composition",
    category: "deck",
    title: "Complete 104-card deck",
    text: `
      The official rules describe 104 cards plus four replacement cards.

      Market cards:
      Market Open: 10
      Market Close: 5
      Peddle: 28
      Protected: 6

      Heat On:
      Bust: 3
      Detained: 3
      Felony: 3
      Search & Seizure: 3

      Heat Off:
      Immunity: 5
      A Breeze To Fly: 5
      Hearsay Evidence: 5
      Charges Dropped: 5

      Pay Fine/Heat Off: 4

      Nirvana:
      Stonehigh: 5
      Euphoria: 1

      Paranoia:
      Sold Out: 4
      Doublecrossed: 3
      Utterly Wiped Out: 1

      Skim:
      Steal Your Neighbor's Pot: 4
      The Banker: 1

      Total: 104 cards.

      The deck also contains four replacement cards that can be customized
      if cards are lost.
    `,
    keywords: [
      "deck",
      "104",
      "104 cards",
      "card count",
      "composition",
      "Market Open",
      "Market Close",
      "Peddle",
      "Protected",
      "Heat On",
      "Heat Off",
      "Pay Fine",
      "Stonehigh",
      "Euphoria",
      "Sold Out",
      "Doublecrossed",
      "Utterly Wiped Out",
      "Steal Your Neighbor's Pot",
      "Banker"
    ]
  },

  // ============================================================
  // CARD INTERACTIONS
  // ============================================================

  {
    id: "heat-interactions",
    category: "interaction",
    title: "Heat interaction summary",
    text: `
      Market Open allows Peddling.

      Heat On is placed over the opponent's Market Open and prevents
      the affected player from Switching, playing Peddles, or playing
      Protected cards.

      A matching Heat Off card removes the specific Heat On card.

      Pay Fine/Heat Off can remove any Heat On but requires discarding
      a Peddle as the fine.

      Stonehigh and Euphoria also remove Heat and provide an extra turn.

      A Heat On card cannot be stacked on another Heat On card.

      Market Close cannot be played while Heat On is showing.
    `,
    keywords: [
      "Heat interaction",
      "Heat On",
      "Heat Off",
      "Pay Fine",
      "Stonehigh",
      "Euphoria",
      "Market Open",
      "Market Close",
      "blocked",
      "Switch",
      "Peddle",
      "Protected"
    ]
  },

  {
    id: "protection-interactions",
    category: "interaction",
    title: "Protection interaction summary",
    text: `
      Protection makes Peddles unavailable to effects that specifically
      target unprotected Peddles.

      Protected Peddles cannot be taken by Steal Your Neighbor's Pot.

      Protected Peddles cannot be selected for Stonehigh or Euphoria,
      which specifically take unprotected Peddles.

      Protected Peddles are not vulnerable to the Peddle-removal portions
      of Sold Out or Doublecrossed because those effects target the
      lowest/highest unprotected Peddle.

      Pay Fine can discard a Protected Peddle as the fine; when this happens
      its Protected cover is discarded as well.

      Utterly Wiped Out destroys the entire Marketplace, including
      Protected cards.
    `,
    keywords: [
      "protection",
      "protected",
      "unprotected",
      "Steal Your Neighbor's Pot",
      "Stonehigh",
      "Euphoria",
      "Sold Out",
      "Doublecrossed",
      "Pay Fine",
      "Utterly Wiped Out"
    ]
  },

  {
    id: "paranoia-passing",
    category: "interaction",
    title: "Paranoia card passing",
    text: `
      When Sold Out, Doublecrossed, or Utterly Wiped Out is played,
      every player passes an undisclosed card from their hand to the
      player ahead of them in the rotation.

      The player who triggered the Paranoia effect participates too.

      This means a player can deliberately play a Paranoia card to get
      rid of a dangerous Paranoia card in their hand, although the card
      they receive from another player is unknown.

      The direction follows the current round's rotation.
    `,
    keywords: [
      "Paranoia",
      "passing",
      "pass card",
      "undisclosed",
      "hand",
      "Sold Out",
      "Doublecrossed",
      "Utterly Wiped Out",
      "rotation",
      "neighbor"
    ]
  },

  // ============================================================
  // STRATEGIC / NATURAL LANGUAGE RECORDS
  // ============================================================

  {
    id: "protect-money",
    category: "strategy",
    title: "Protecting money",
    text: `
      Peddles are initially exposed when played because Peddles must be
      played before Protected cards.

      A player can subsequently cover Peddles with Protected cards.

      Protection coverage must be at least equal to the Peddle value.
      A Protected card can cover multiple Peddles, but additional Peddles
      cannot be added underneath an already placed Protected card.

      Dr. Feelgood cannot be protected.

      Keeping money in the hand is also risky because the highest Peddle
      remaining in the hand is deducted during scoring.
    `,
    keywords: [
      "protect money",
      "protect stash",
      "protect Peddle",
      "exposed",
      "risk",
      "Protected",
      "Dr Feelgood",
      "hand",
      "scoring"
    ]
  },

  {
    id: "how-to-remove-heat",
    category: "strategy",
    title: "Ways to remove Heat",
    text: `
      There are three categories of effects that can neutralize Heat On:

      1. The matching Heat Off card.
         Bust -> Immunity
         Detained -> A Breeze To Fly
         Felony -> Hearsay Evidence
         Search & Seizure -> Charges Dropped

      2. Pay Fine/Heat Off.
         Removes any Heat On but requires discarding a Marketplace Peddle.

      3. Stonehigh or Euphoria.
         Removes Heat and grants an extra turn while also taking
         unprotected Peddles from other players.

      A player can also Trade with another player to obtain the required
      matching Heat Off card.
    `,
    keywords: [
      "remove Heat",
      "get rid of Heat",
      "cancel Heat",
      "Heat Off",
      "Pay Fine",
      "Stonehigh",
      "Euphoria",
      "Trade",
      "Immunity",
      "Hearsay Evidence",
      "Charges Dropped",
      "A Breeze To Fly"
    ]
  },

  {
    id: "how-to-steal",
    category: "strategy",
    title: "Ways to steal Peddles",
    text: `
      Steal Your Neighbor's Pot directly takes one unprotected Peddle
      from another player.

      The thief must have an open, hassle-free Marketplace.

      The victim must also have an open, hassle-free Marketplace.

      The Banker is different: it is held in hand until scoring and
      skims $5,000 from every other player who has unprotected Peddles,
      plus gives the Banker holder a $5,000 bonus.

      Switch can also exchange a visible unprotected Peddle between
      two Marketplaces.
    `,
    keywords: [
      "steal",
      "take Peddle",
      "Steal Your Neighbor's Pot",
      "Banker",
      "Switch",
      "unprotected",
      "Marketplace",
      "hassle-free",
      "5000"
    ]
  },

  // ============================================================
  // OPTIONAL VARIANTS
  // ============================================================

  {
    id: "variant-give-me-five",
    category: "variant",
    title: "Give Me Five variant",
    text: `
      Give Me Five is an optional setup variant.

      At the beginning of a round, each player receives six cards.
      Each player secretly sets aside one card to keep and passes the
      remaining five cards to the player on their left.

      Each player then chooses one card from the five received and passes
      the other four onward.

      This continues until the final card is reached.

      The direction of the draft reverses in alternate rounds.
    `,
    keywords: [
      "Give Me Five",
      "draft",
      "variant",
      "setup",
      "six cards",
      "5 cards",
      "pass",
      "left",
      "alternate"
    ]
  },

  {
    id: "variant-hidden-deals",
    category: "variant",
    title: "Hidden Deals variant",
    text: `
      In Hidden Deals, Trades are made face down.

      Two players exchange an undisclosed card between their hands.

      A player can claim to be trading a Market Open but secretly give
      a Doublecrossed card instead.

      A player who receives a hidden card may say they were cheated,
      whether or not they actually were, but cannot show the received
      card to the other players.
    `,
    keywords: [
      "Hidden Deals",
      "hidden trade",
      "face down",
      "undisclosed",
      "bluff",
      "Doublecrossed",
      "Market Open",
      "variant"
    ]
  },

  {
    id: "variant-lucky-or-not",
    category: "variant",
    title: "Lucky or Not variant",
    text: `
      In Lucky or Not, the normal Paranoia card-passing rule is replaced.

      When Sold Out, Doublecrossed, or Utterly Wiped Out is played,
      players do not pass an undisclosed card to the player ahead.

      Instead, beginning with the player who played the Paranoia card
      and continuing clockwise, each player takes a random card from
      the hand of the player to their right.
    `,
    keywords: [
      "Lucky or Not",
      "variant",
      "Paranoia",
      "random",
      "random card",
      "Sold Out",
      "Doublecrossed",
      "Utterly Wiped Out",
      "clockwise"
    ]
  },

  {
    id: "variant-cool-the-heat",
    category: "variant",
    title: "Cool the Heat variant",
    text: `
      Cool the Heat is an optional variant that makes the game easier.

      Under this variant, ANY Heat Off card can cancel ANY Heat On card.

      The normal matching requirement is removed.

      This can keep players active and reduce the difficulty of finding
      the exact corresponding Heat Off card.
    `,
    keywords: [
      "Cool the Heat",
      "variant",
      "Heat Off",
      "Heat On",
      "any Heat Off",
      "any Heat On",
      "matching"
    ]
  }
];

export const fuseOptions = {
  // Fuzzy search rather than exact string matching.
  threshold: 0.32,

  // Return useful relevance information.
  includeScore: true,
  includeMatches: true,

  // Search all of these fields.
  keys: [
    {
      name: "title",
      weight: 2.0
    },
    {
      name: "keywords",
      weight: 1.7
    },
    {
      name: "text",
      weight: 1.0
    },
    {
      name: "category",
      weight: 0.5
    }
  ],

  // Useful for natural-language questions.
  ignoreLocation: true,
  minMatchCharLength: 2,
  shouldSort: true
};

export default grassRules;
